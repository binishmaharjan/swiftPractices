//
//  Character.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

struct Character: Codable {
  let malId: Int
  let name: String
  let role: String
  
  enum CodingKeys: String, CodingKey {
    case malId = "mal_id"
    case name
    case role
  }
}

struct Characters: Codable {
  let characters: [Character]
}
