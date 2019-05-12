//
//  GoodNewsNavigationController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/05/02.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class GoodNewsNavigationController: UINavigationController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    navigationBar.barTintColor = UIColor(red: 47/255, green: 54/255, blue: 64/255, alpha: 1)
    navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
  }
}
