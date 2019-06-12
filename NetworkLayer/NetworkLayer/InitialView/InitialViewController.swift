//
//  InitialViewController.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
  
  let initialView = InitialView.loadXib()
  
  override func loadView() {
    self.view = initialView
  }
  
}
