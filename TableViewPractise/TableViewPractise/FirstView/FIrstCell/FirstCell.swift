//
//  FirstCell.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/22.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class FirstCell: UITableViewCell {

  @IBOutlet weak var firstLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension FirstCell: HasXib {}
