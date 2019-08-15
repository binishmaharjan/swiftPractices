//
//  Extension+Double.swift
//  TipCalculator
//
//  Created by Maharjan Binish on 2019/08/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation


extension Double {
  var toString: String {
    return String.init(format: "%0.2f", self)
  }
  
}

