//
//  CellTableViewCell.swift
//  TableViewWithEnum
//
//  Created by Maharjan Binish on 2019/11/03.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
  // MARK: - Outlets
  @IBOutlet weak var titleLabel: UILabel!
  
  // MARK: - Methods
  func set(_ title: String) {
    self.titleLabel.text = title
  }
    
}

extension Cell: XibLoadable { }
