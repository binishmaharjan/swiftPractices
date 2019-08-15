//
//  PetView.swift
//  PetMVVM
//
//  Created by Maharjan Binish on 2019/08/06.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class PetView: UIView {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var adoptionFeeLabel: UILabel!
}

extension PetView: HasXib { }
