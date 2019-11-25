//
//  HasXib.swift
//  TableViewWithEnum
//
//  Created by Maharjan Binish on 2019/11/03.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

protocol XibLoadable { }

extension XibLoadable {
  static var xibName: String {
    return String(describing: Self.self)
  }
}

extension XibLoadable where Self: UITableViewCell {
  static var xib: UINib {
    let bundle = Bundle(for: self)
    return UINib(nibName: xibName, bundle: bundle)
  }
}
