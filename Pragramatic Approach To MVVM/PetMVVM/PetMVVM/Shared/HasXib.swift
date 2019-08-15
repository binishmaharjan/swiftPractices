//
//  HasXib.swift
//  PetMVVM
//
//  Created by Maharjan Binish on 2019/08/06.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

protocol HasXib { }
extension HasXib where Self: UIView{
  static var xibName: String { return String(describing: Self.self) }
  
  static func loadXib() -> Self {
    return UINib(nibName: xibName, bundle: nil).instantiate(withOwner: self, options: nil).first as! Self
  }
}
