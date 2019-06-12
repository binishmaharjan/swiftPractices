//
//  ThirdCell.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/25.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class ThirdCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    profileImage.layer.borderColor = UIColor(named: "mainPurple")!.cgColor
    profileImage.layer.borderWidth = 2
  }
  
}

extension ThirdCell: HasXibThird {}
