//
//  CharacterSerializer.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

struct CharacterSerializer: Serializable {
  
  typealias SerializingType = Characters
  
  static func serialize(data: Data) -> Characters? {
    return CodableSerializer<SerializingType>.serialize(data: data)
  }
  
}
