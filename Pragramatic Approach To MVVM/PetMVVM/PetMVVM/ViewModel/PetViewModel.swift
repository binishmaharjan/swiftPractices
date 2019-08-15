//
//  PetViewModel.swift
//  PetMVVM
//
//  Created by Maharjan Binish on 2019/08/06.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

class PetViewModel {
  
  private let pet: Pet
  private let calender: Calendar
  
  init(pet: Pet) {
    self.pet = pet
    self.calender = Calendar(identifier: .gregorian)
  }
  
  var name: String { return pet.name }
  var image: String { return pet.image }
  var ageText: String {
    let today = calender.startOfDay(for: Date())
    let birthday = calender.startOfDay(for: pet.birthday)
    let compenents = calender.dateComponents([.year], from: birthday, to: today)
    let age = compenents.year!
    return "\(age) years old"
  }
  var adoptionFeeText: String {
    switch pet.rarity {
    case .common:
      return "$50.0"
    case .uncommon:
      return "$150.0"
    case .rare:
      return "$250.0"
    case .veryRare:
      return "$500.0"
    }
  }
}

import UIKit

extension PetViewModel {
  func configure(view: PetView) {
    view.nameLabel.text = name
    view.imageView.image = UIImage(named: pet.image)
    view.adoptionFeeLabel.text = adoptionFeeText
    view.ageLabel.text = ageText
  }
}
