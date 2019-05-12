//
//  ViewController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/04/28.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var cameraFilterButton: UIButton!
  @IBOutlet weak var goodListButton: UIButton!
  @IBOutlet weak var goodNewsButton: UIButton!
  @IBOutlet weak var goodWeatherButton: UIButton!
  @IBOutlet weak var goodNewsMVVMButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cameraFilterButton.layer.borderColor = UIColor.black.cgColor
    cameraFilterButton.layer.cornerRadius = 2
    cameraFilterButton.layer.borderWidth = 1
    
    goodListButton.layer.borderColor = UIColor.black.cgColor
    goodListButton.layer.cornerRadius = 2
    goodListButton.layer.borderWidth = 1
    
    goodNewsButton.layer.borderColor = UIColor.black.cgColor
    goodNewsButton.layer.cornerRadius = 2
    goodNewsButton.layer.borderWidth = 1
    
    goodWeatherButton.layer.borderColor = UIColor.black.cgColor
    goodWeatherButton.layer.cornerRadius = 2
    goodWeatherButton.layer.borderWidth = 1
    
    goodNewsMVVMButton.layer.borderColor = UIColor.black.cgColor
    goodNewsMVVMButton.layer.cornerRadius = 2
    goodNewsMVVMButton.layer.borderWidth = 1
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "cvfc" {
      if let vc = segue.destination as? CameraFilterViewController {
        self.present(vc, animated: true, completion: nil)
      }
    }
    
    if segue.identifier == "glvc" {
      if let vc = segue.destination as? TaskListViewController {
        self.present(vc, animated: true, completion: nil)
      }
    }
    
    if segue.identifier == "gnvc" {
      if let vc = segue.destination as? GoodNewsViewController {
        self.present(vc, animated: true, completion: nil)
      }
    }
    
    if segue.identifier == "gwvc" {
      if let vc = segue.destination as? GoodWeatherViewController {
        self.present(vc, animated: true, completion: nil)
      }
    }
    
    if segue.identifier == "gnmvvmvc" {
      if let vc = segue.destination as? GoodNewsMVVMViewController {
        self.present(vc, animated: true, completion: nil)
      }
    }
  }
}

