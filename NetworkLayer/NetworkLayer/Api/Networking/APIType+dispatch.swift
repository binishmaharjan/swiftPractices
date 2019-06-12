//
//  APIType+dispatch.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import Foundation

extension APIType {
  
  func dispatch(dispatcher: RequestDispatchable = URLSessionRequestDispatcher(),
                onSuccess: @escaping (ResponseType) -> Void,
                onError: @escaping (Error) -> Void) {
    dispatcher.dispatch(request: self.request, onSuccess: { (responseData: Data) in
      guard let parseData = self.responseSerializer(responseData) else {
        onError(APIError.responseParseFailed)
        return
      }
      
      DispatchQueue.main.async {
        onSuccess(parseData)
      }
    }, onError: { (error: Error) in
      DispatchQueue.main.async {
        onError(error)
      }
    })
  }
}
