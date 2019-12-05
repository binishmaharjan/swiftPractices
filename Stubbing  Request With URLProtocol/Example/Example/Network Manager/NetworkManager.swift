//
//  NetworkManager.swift
//  Example
//
//  Created by Maharjan Binish on 2019/12/05.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class NetworkManager {
  
  enum Error: Swift.Error {
    case invalidParameter(String)
  }
  
  /// Make HTTP Request
  ///
  /// - Parameter urlString: url for the request
  /// - Parameter parameter: parameters for the request
  /// - Parameter handlers: closure for handling the result of the request
  func makeRequest(urlString: String, parameter: [String: Any], handlers: @escaping (Any?, Swift.Error?) -> Void) {
    // Create URL
    let url = URL(string: urlString)
    guard let requestUrl = url else { fatalError() }
    // Create URL Request
    var request = URLRequest(url: requestUrl)
    // Specify HTTP Method to use
    request.httpMethod = "GET"
    // Send HTTP Request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // Check if Error took place
        if let error = error {
          handlers(nil,NetworkManager.Error.invalidParameter(error.localizedDescription))
            return
        }
        
        // Read HTTP Response Status code
        if let response = response as? HTTPURLResponse {
            print("Response HTTP Status code: \(response.statusCode)")
        }
        
        // Convert HTTP Response Data to a simple String
      guard let data = data else {
        handlers(nil,NetworkManager.Error.invalidParameter("Empty Data"))
        return
      }
      
      if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
          handlers(json, nil)
      } else {
          handlers(nil, error)
      }
        
    }
    task.resume()

  }
}
