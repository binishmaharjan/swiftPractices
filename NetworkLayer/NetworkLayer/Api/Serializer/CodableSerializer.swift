//
//  CodableSerializer.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

struct CodableSerializer<T:Codable>: Serializable {
  
  typealias SerializingType = T
  
  static func serialize(data: Data) -> T? {
    do {
      
      let jsonDecoder = JSONDecoder()
      let serialized = try jsonDecoder.decode(SerializingType.self, from: data)
      return serialized
      
    } catch {
      return nil
    }
    
  }
}
