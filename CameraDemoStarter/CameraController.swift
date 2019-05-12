//
//  CameraController.swift
//  AV Foundation
//
//  Created by Maharjan Binish on 2019/05/11.
//  Copyright © 2019 Pranjal Satija. All rights reserved.
//

import AVFoundation
import UIKit

class CameraController: NSObject {
  
  var captureSession: AVCaptureSession?
  
  var currentCameraPostion: CameraPosition?
  
  var frontCamera: AVCaptureDevice?
  var frontCameraInput: AVCaptureDeviceInput?

  var rearCamera: AVCaptureDevice?
  var rearCameraInput: AVCaptureDeviceInput?
  
  var photoOutput: AVCapturePhotoOutput?
  
  var previewLayer: AVCaptureVideoPreviewLayer?
  
  var flashMode = AVCaptureDevice.FlashMode.off
  
  var photoCaptureCompletionBlock: ((UIImage?, Error?) -> Void)?
}

extension CameraController {
  func prepare(completionHandler: @escaping (Error?) -> Void) {
    func createCaptureSession() {
      self.captureSession = AVCaptureSession()
    }
    
    func configureCaptureDevices() throws {
      let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
      
      let cameras = (session.devices.compactMap {$0})
      guard !cameras.isEmpty else {
        throw CameraControllerError.noCamerasAvailable
      }
      
      for camera in cameras {
        if camera.position == .front {
          self.frontCamera = camera
        }
        
        if camera.position == .back {
          self.rearCamera = camera
          
          try camera.lockForConfiguration()
          camera.focusMode = .continuousAutoFocus
          camera.unlockForConfiguration()
        }
      }
    }
    
    func configureDeviceInputs() throws {
      guard let captureSession = self.captureSession else {
        throw CameraControllerError.captureSessionIsMissing
      }
      
      if let rearCamera = self.rearCamera {
        self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
        
        if captureSession.canAddInput(self.rearCameraInput!) {
          captureSession.addInput(self.rearCameraInput!)
          self.currentCameraPostion = .rear
        }
      } else if let frontCamera = self.frontCamera {
        self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
        
        if !(captureSession.canAddInput(self.frontCameraInput!)) {
          throw CameraControllerError.inputsAreInvalid
        }
        captureSession.addInput(self.frontCameraInput!)
        self.currentCameraPostion = .front
        
      } else {
        throw CameraControllerError.noCamerasAvailable
      }
    }
    
    func configurePhotoOutput() throws{
      guard let captureSession = self.captureSession else {
        throw CameraControllerError.captureSessionIsMissing
      }
      
      let avCapturePhotoSetting = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecJPEG])
      self.photoOutput = AVCapturePhotoOutput()
      self.photoOutput!.setPreparedPhotoSettingsArray([avCapturePhotoSetting], completionHandler: nil)
      
      if captureSession.canAddOutput(self.photoOutput!) {
        captureSession.addOutput(self.photoOutput!)
      }
      
      captureSession.startRunning()
    }
    
    DispatchQueue(label: "prepare").async {
      do{
        createCaptureSession()
        try configureCaptureDevices()
        try configureDeviceInputs()
        try configurePhotoOutput()
      } catch {
        DispatchQueue.main.async {
          completionHandler(error)
        }
        return
      }
      
      DispatchQueue.main.async {
        completionHandler(nil)
      }
    }
  }
}

extension CameraController {
  func displayPreview(on view: UIView) throws {
    guard let captureSession = self.captureSession, captureSession.isRunning else {
      throw CameraControllerError.captureSessionIsMissing
    }
    
    self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
    self.previewLayer?.connection?.videoOrientation = .portrait
    
    view.layer.insertSublayer(self.previewLayer!, at: 0)
    self.previewLayer?.frame = view.frame
  }

  func switchCamera() throws {
    guard let currentCameraPostion = currentCameraPostion,
      let captureSession = self.captureSession,
      captureSession.isRunning else {
      throw CameraControllerError.captureSessionIsMissing
    }
    
    let inputs = captureSession.inputs
    captureSession.beginConfiguration()
    
    func switchToFrontCamera() throws {
      guard let rearCameraInput = self.rearCameraInput,
        inputs.contains(rearCameraInput),
        let frontCamera = self.frontCamera else {
        throw CameraControllerError.invalidOperation
      }
      
      self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
      captureSession.removeInput(rearCameraInput)
      
      if captureSession.canAddInput(self.frontCameraInput!) {
        captureSession.addInput(self.frontCameraInput!)
      }
      
      self.currentCameraPostion = .front
    }
    
    func switchToRearCamera() throws {
      guard let frontCameraInput = self.frontCameraInput,
        inputs.contains(frontCameraInput),
        let rearCamera = self.rearCamera else {
        throw CameraControllerError.invalidOperation
      }
      
      self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
      captureSession.removeInput(frontCameraInput)
      
      if captureSession.canAddInput(self.rearCameraInput!) {
        captureSession.addInput(self.rearCameraInput!)
      }
      
      self.currentCameraPostion = .rear
    }
    
    switch currentCameraPostion {
    case .front:
      try switchToRearCamera()
      
    case .rear:
      try switchToFrontCamera()
    }
    
    captureSession.commitConfiguration()
  }
  
  func captureImage(completion: @escaping (UIImage?, Error?) -> Void) {
    guard let captureSession = captureSession, captureSession.isRunning else {
      completion(nil, CameraControllerError.captureSessionIsMissing)
      return
    }
    
    let settings = AVCapturePhotoSettings()
    settings.flashMode = self.flashMode
    
    self.photoOutput?.capturePhoto(with: settings, delegate: self)
    self.photoCaptureCompletionBlock = completion
  }
}


extension CameraController: AVCapturePhotoCaptureDelegate {
  public func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                          didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                          previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,resolvedSettings: AVCaptureResolvedPhotoSettings,
                          bracketSettings: AVCaptureBracketedStillImageSettings?,
                          error: Swift.Error?) {
    
    if let error = error {
      self.photoCaptureCompletionBlock?(nil,error)
    } else if let buffer = photoSampleBuffer, let data = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: buffer, previewPhotoSampleBuffer: nil), let image = UIImage(data: data) {
        self.photoCaptureCompletionBlock?(image,nil)
    } else {
      self.photoCaptureCompletionBlock?(nil,CameraControllerError.unknown)
    }
  }
}

extension CameraController {
  enum CameraControllerError: Swift.Error {
    case captureSessionAlreadyRunning
    case captureSessionIsMissing
    case inputsAreInvalid
    case invalidOperation
    case noCamerasAvailable
    case unknown
  }
  
  public enum CameraPosition {
    case front
    case rear
  }
}
