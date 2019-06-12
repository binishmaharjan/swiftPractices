//
//  Custom Buttons.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/22.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layer.cornerRadius = 20
  }
  
}


class PurpleRoundButton: RoundButton {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = UIColor.purple.withAlphaComponent(0.7)
    self.setTitleColor(UIColor.white, for: .normal)
  }
  
}
