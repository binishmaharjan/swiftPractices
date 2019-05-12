//
//  FIilterService.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/04/29.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import CoreImage
import RxSwift

class FilterService {
  private var context: CIContext
  init() {
    self.context = CIContext()
  }
  
  func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
    return Observable<UIImage>.create{ observer in
      self.applyFilter(to: inputImage, completion: { (filteredImage) in
        observer.onNext(filteredImage)
      })
      return Disposables.create()
    }
  }
  
  private func applyFilter(to inputImage: UIImage, completion: ((UIImage) -> Void)) {
    let filter = CIFilter(name: "CICMYKHalftone")!
    filter.setValue(0.5, forKey: kCIInputWidthKey)
    if let sourceImage = CIImage(image: inputImage) {
      filter.setValue(sourceImage, forKey: kCIInputImageKey)
      if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        completion(processedImage)
      }
    }
  }
}
