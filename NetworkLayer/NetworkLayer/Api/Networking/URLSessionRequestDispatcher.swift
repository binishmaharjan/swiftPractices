//
//  URLSessionRequestDispatcher.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/13.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

struct URLSessionRequestDispatcher: RequestDispatchable {
  
  init() {}
  func dispatch(request: Request,
                onSuccess: @escaping (Data) -> Void,
                onError: @escaping (Error) -> Void) {
    
    guard let urlRequest = createURLRequest(by: request, onError: onError) else { return }
    

    print(urlRequest.httpMethod!)
    print(urlRequest.url!)
    print(urlRequest.allHTTPHeaderFields!)
    
    
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      
      //Checking the status code
      if let httpResponse = response as? HTTPURLResponse {
        print(httpResponse.statusCode)
      }
      
      if let error = error {
        
        onError(error)
        return
      }
      
      guard let data = data else {
        onError(APIError.noResponseData)
        return
      }
      onSuccess(data)
    }.resume()
    
  }
  
  private func createURLRequest(by restURLRequest: Request, onError: (Error) -> Void) -> URLRequest? {
    
    //Create URL Request
    guard let url = URL(string: restURLRequest.url) else {
      onError(APIError.noResponseData)
      return nil
    }
    var urlRequest = URLRequest(url: url)
    
    //Set HTTP Method
    urlRequest.httpMethod = restURLRequest.method.rawValue
    
    
    //Set Param
    do{
      if let params = restURLRequest.params {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
      }
    } catch {
      onError(error)
      return nil
    }
    
    //Set headers
    if let headers = restURLRequest.headers {
      urlRequest.allHTTPHeaderFields = headers
    }
    
    return urlRequest
    
  }
}
