//
//  GoodNewsMVVMNavigationViewController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/05/09.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class GoodNewsMVVMNavigationViewController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationBar.barTintColor = UIColor(red: 142/255, green: 68/255, blue: 173/255, alpha: 1)
    self.navigationBar.prefersLargeTitles = true
    self.navigationBar.largeTitleTextAttributes = [NSMutableAttributedString.Key.foregroundColor : UIColor.white]
    self.navigationBar.titleTextAttributes = [NSMutableAttributedString.Key.foregroundColor : UIColor.white]
  }
  
}
