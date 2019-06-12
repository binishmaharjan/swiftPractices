//
//  ApiError.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

enum APIError: Error {
  case urlNotValid
  case noResponseData
  case responseParseFailed
}
