//
//  SecondView.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/23.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class SecondView: UIView {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
}

extension SecondView: HasXib2 {}

protocol HasXib2 {}
extension HasXib2 {
  
  static var xibName: String {
    return String(describing: Self.self)
  }
  
  static func loadXib() -> Self {
    return UINib(nibName: xibName, bundle: nil).instantiate(withOwner: self, options: nil).first as! Self
  }
  
  static func loadNib() -> UINib {
    return UINib(nibName: xibName, bundle: nil)
  }
}
