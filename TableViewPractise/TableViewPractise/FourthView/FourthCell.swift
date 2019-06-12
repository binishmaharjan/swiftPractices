//
//  FourthCell.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/06/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class FourthCell: UITableViewCell {

  @IBOutlet weak var userLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension FourthCell: HasXibThird {}
