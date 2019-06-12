//
//  FirstViewController.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/22.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  
  override func loadView() {
    self.view = FirstView.loadXib()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Two Segmented Title View"
  }
}
