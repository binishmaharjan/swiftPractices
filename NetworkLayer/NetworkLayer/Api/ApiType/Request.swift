//
//  Request.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

/*
 
 APITypeのpropertyの内、HTTPリクエストを送る際に必要な情報を保持。
 
 */

struct Request {
  
  //Property
  let url: String
  let method: HTTPMethod
  let params: [String: Any?]?
  let headers: [String: String]?
  
  //Init
  public init (url: String,
               method: HTTPMethod,
               params: [String: Any?]? = nil,
               headers: [String: String]? = nil) {
    self.url = url
    self.method = method
    self.params = params
    self.headers = headers
  }
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
  case patch = "PATCH"
}
