//
//  Pet.swift
//  PetMVVM
//
//  Created by Maharjan Binish on 2019/08/06.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

class Pet {
  enum Rarity {
    case common
    case uncommon
    case rare
    case veryRare
  }
  
  let name: String
  let birthday: Date
  let rarity: Rarity
  let image: String
  
  init(name: String, birthday: Date, rarity: Rarity, image: String) {
    self.name = name
    self.birthday = birthday
    self.rarity = rarity
    self.image = image
  }
}
