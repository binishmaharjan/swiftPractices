//
//  SecondCell.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/23.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class SecondCell: UITableViewCell {

  @IBOutlet weak var secondLabel: UILabel!
  var selectionColor: UIColor {
    set{
      let view = UIView()
      view.backgroundColor = newValue
      self.selectedBackgroundView = view
    }
    get{
      return self.selectedBackgroundView?.backgroundColor ?? UIColor.clear
    }
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension SecondCell: HasXib2 {}

//extension UITableViewCell {
//  var selectionColor: UIColor {
//    set {
//      let view = UIView()
//      view.backgroundColor = newValue
//      self.selectedBackgroundView = view
//    }
//    get {
//      return self.selectedBackgroundView?.backgroundColor ?? UIColor.clear
//    }
//  }
//}
