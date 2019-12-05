//
//  ViewController.swift
//  Example
//
//  Created by Maharjan Binish on 2019/12/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // usage
    NetworkCapture.setup()

    let apis: [String] = [
        "http://www.example.com/notice",
        "http://www.example.com/maintenance",
        "http://www.example.com/error",
        "http://www.example.com/notfound",
        "https://jsonplaceholder.typicode.com/todos/1"
    ]
//    apis.forEachAsync { urlString, next in
//        HttpClient().get(urlString: urlString, parameters: ["foo": "bar", "baz": "1"]) { json, error in
//            if let error = error {
//                print("  * Response Error: \(error)")
//            } else if let json = json as? [String: [[String: Any]]] {
//                print("  * Response JSON(notice): \(json)")
//            } else if let json = json as? [String: Any] {
//                print("  * Response JSON(maintenance): \(json)")
//            } else {
//                print("  * Response Other: \(String(describing: json))")
//            }
//            next()
//        }
//    }
    
    apis.forEachAsync { (urlString, next) in
      NetworkManager().makeRequest(urlString: urlString, parameter: [:]) { (json, error) in
        if let error = error {
          print("  * Response Error: \(error)")
        } else if let json = json as? [String: [[String: Any]]] {
          print("  * Response JSON(notice): \(json)")
        } else if let json = json as? [String: Any] {
          print("  * Response JSON(maintenance): \(json)")
        } else {
          print("  * Response Other: \(String(describing: json))")
        }
        next()
      }
    }
    
  }


}

