//
//  HasXib.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

protocol HasXib {}

extension HasXib {
  static var xibName: String {
    return String(describing: Self.self)
  }
}

extension HasXib where Self: UIView {
  static func loadXib() -> Self {
    return UINib(nibName: xibName, bundle: nil).instantiate(withOwner: self, options: nil).first as! Self
  }
}

extension HasXib where Self: UITableViewCell {
  static func loadNib() -> UINib {
    return UINib(nibName: xibName, bundle: nil)
  }
}
