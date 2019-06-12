//
//  HasXibThird.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/25.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

protocol HasXibThird {}

extension HasXibThird {
  
  static var xibName: String {
    return String(describing: Self.self)
  }
  
}

extension HasXibThird where Self : UIView {
  
  static func loadXib() -> Self {
    return UINib(nibName: xibName, bundle: nil).instantiate(withOwner: self, options: nil).first as! Self
  }
  
}

extension HasXibThird where Self: UITableViewCell {
  
  static func loadNib() -> UINib {
    return UINib(nibName: xibName, bundle: nil)
  }
  
}
