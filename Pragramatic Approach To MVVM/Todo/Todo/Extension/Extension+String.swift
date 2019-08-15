//
//  Extension+String.swift
//  Todo
//
//  Created by Maharjan Binish on 2019/08/05.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

extension String {
  
  var strikeThrough: NSAttributedString {
    let attributedString = NSMutableAttributedString(string: self)
    attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                  value: NSUnderlineStyle.single.rawValue,
                                  range: NSMakeRange(0, attributedString.length))
    return attributedString
  }
  
}
