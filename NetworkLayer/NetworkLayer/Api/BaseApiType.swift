//
//  BaseApiType.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/13.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

protocol BaseAPIType: APIType {
  var httpMethod: HTTPMethod { get }
  var path: String { get }
  var params: [String: Any] { get }
  var header: [String: String] { get }
}

extension BaseAPIType {
  
  var url: String {
    let baseURL = "https://api.jikan.moe/v3/"
    return baseURL + self.path
  }
  
  var request: Request {
    return Request(url: self.url,
                   method: self.httpMethod,
                   params: nil,
                   headers: self.header)
  }
}
