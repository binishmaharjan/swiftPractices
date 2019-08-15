//
//  SimpleMVVMCell.swift
//  SimpleMMVM
//
//  Created by Maharjan Binish on 2019/08/03.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit


class SimpleMVVMCell: UITableViewCell {
  
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var colorView: UIView!
  @IBOutlet weak var colorName: UILabel!
  
  var data: SimpleModel? {
    didSet {
      guard let data = data else { return }
      self.populateData(data: data)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setup()
  }
  
  private func setup() {
    self.colorView.layer.cornerRadius = 40
    self.colorView.clipsToBounds = true
    self.baseView.layer.cornerRadius = 40
    self.baseView.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMinXMaxYCorner ]
  }
  
  private func populateData(data: SimpleModel) {
    self.baseView.backgroundColor = data.color.withAlphaComponent(0.5)
    self.colorView.backgroundColor = data.color
    self.colorName.text = data.text
  }
  
}
