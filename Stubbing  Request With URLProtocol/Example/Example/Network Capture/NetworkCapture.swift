//
//  NetworkCapture.swift
//  Example
//
//  Created by Maharjan Binish on 2019/12/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

final class NetworkCapture: URLProtocol {
  
  /// Activate the class
  class func setup() {
    let isOk = URLProtocol.registerClass(NetworkCapture.self)
    assert(isOk, "NetworkCapture registration failed")
    
    URLSessionConfiguration.default.protocolClasses?.insert(NetworkCapture.self, at: 0)
    
    setupHandlers()
  }
  
  private static var entryItems = NetworkCaptureEntry()
  
  // Hook Defination
  private static func setupHandlers() {
    entryItems.add(urlString: {
      $0.contains("/maintenance")
    }, data: { _ in
      StubData.maintenance.asData()
    })
    .add(urlString: {
      $0.contains("/notice")
    }, data: { _ in
      StubData.notice.asData()
    })
    .add(urlString: {
      $0.contains("/error")
    }, data: { _ in
      StubData.empty.asData()
    }, error: { _ in
      NSError(domain: "test.api.error", code: -1, userInfo: nil) as Error
    })
  }
  
  /// Determines whether the protocol subclass can handle the specified request.
  ///
  /// - Parameter request: a urlRequest
  /// - Returns: if return true here, this class will be instantiated and used
  override class func canInit(with request: URLRequest) -> Bool {
    let method = request.httpMethod ?? ""
    let url = request.url?.absoluteString ?? ""
    print("[\(method)] \(url)")
    
    return entryItems.isWantHook(request: request)
  }
  
  /// Returns a canonical version of the specified request.
  ///
  /// - Parameter request: a urlRequest
  /// - Returns: returns the proccessed request if needed, otherwise just return the original request
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  /// Used for cache comparison
  ///
  /// - Parameter lhs: first urlRequest
  /// - Parameter rhs: the second urlRequest
  /// - Returns: true if we need caching, if we don't need any caching, just return false
  override class func requestIsCacheEquivalent(_ lhs: URLRequest, to rhs: URLRequest) -> Bool {
    return false
  }
  
  /// Called at the start of the connection
  override func startLoading() {
    guard let client = client, let url = request.url else {
      return
    }
    
    let result = type(of: self).entryItems.performHook(request: request)
    print("   * hooked")
    
    // Error Handling
    if let error = result.error {
      client.urlProtocol(self, didFailWithError: error)
      return
    }
    
    // Success
    let commonHeaders: [String: String] = [
        "Content-Language": "ja",
        "Content-Type": "text/plain; charset=utf-8"
    ]
    
    if let response = HTTPURLResponse(url: url, statusCode: result.status, httpVersion: "1.0", headerFields: commonHeaders) {
      client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }
    
    if let data = result.data {
      client.urlProtocol(self, didLoad: data)
    }
    
    client.urlProtocolDidFinishLoading(self)
  }
  
  /// called at the end of the connection
  override func stopLoading() {
    
  }
}

extension NetworkCapture {
  /// Hook defination container
  final class NetworkCaptureEntry {
    private var stringItems: [StringItem] = []
    
    /// Add a hook defination
    ///
    /// - Parameter urlString: true if should hook
    /// - Parameter data: called when hooked. return the response data
    /// - Parameter error: Called when hooked. Use it if you want to return an error
    /// - Returns: Self (Useable for method chaining)
    @discardableResult
    func add(urlString: @escaping (String) -> Bool,
             data: @escaping (String) -> Data?,
             error: @escaping (String) -> Error? = { _ in nil }) -> NetworkCaptureEntry {
      stringItems.append(StringItem(urlString: urlString, data: data, error: error, status: { 200 }))
      return self
    }
    
    /// Judgement for the hook
    ///
    ///- Parameter request: a URLRequest
    /// - Returns: true if should hook
    func isWantHook(request: URLRequest) -> Bool {
      if let urlString = request.url?.absoluteString {
        return stringItems.contains(where: { $0.urlString(urlString) })
      }
      
      return false
    }
    
    /// Perform hook information
    ///
    /// - Parameter request: a UrlRequest
    /// - Returns: response data, http status, error for response
    func performHook(request: URLRequest) -> (data: Data?, status: Int, error: Error?) {
      var data: Data?
      var status = 404
      var error: Error?
      
      if let urlString = request.url?.absoluteString,
        let item = stringItems.first(where: { $0.urlString(urlString) }) {
        data = item.data(urlString)
        error = item.error(urlString)
        status = item.status()
      }
      
      return (data: data, status: status, error: error)
    }
    
    /// Hook Defination
    private struct StringItem {
      var urlString: (String) -> Bool
      var data: (String) -> Data?
      var error: (String) -> Error?
      var status: () -> Int
    }
  }
}

private enum StubData: String {
  /// Convert to data type
  ///
  /// - Returns: data
  func asData() -> Data? {
    return rawValue.data(using: .utf8, allowLossyConversion: true)
  }
  
  // MARK: - Describe the stub data BELOW
  case empty = "{}"
  case maintenance = """
  {
  "code": 100,
  "message": "Under Maintenance."
  }
  """
  case notice = """
  {
  "notice": [
  {
  "code": 100,
  "title": "Notification 1."
  },
  {
  "code": 102,
  "title": "Notification 2."
  }
  ]
  }
  """
}

