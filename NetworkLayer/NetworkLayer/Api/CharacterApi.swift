//
//  CharacterApi.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/13.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

enum CharacterApi: BaseAPIType {
  
  case all
  case latest(requestParam: [String: Any])
  
  typealias ResponseType = Characters
  
  var path: String {
    switch self {
    case .all:
      return "manga/2/characters"
    case .latest:
      return "manga/2/characters"
    }
  }
  
  var params: [String : Any] {
    switch self {
    case .all:
      return [:]
    case .latest(let requestParam):
      return requestParam
    }
  }
  
  var httpMethod: HTTPMethod {
    return .get
  }
  
  var header: [String : String] {
    return ["Content-Type" : "application/json"]
  }
  
  var responseSerializer: ((Data) -> (Characters?)) {
    // 先に別途定義したUserSerializerを使用
    return CharacterSerializer.serialize
  }
}
