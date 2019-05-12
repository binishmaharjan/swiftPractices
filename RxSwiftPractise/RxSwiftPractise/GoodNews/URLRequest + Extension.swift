//
//  URLRequest + Extension.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/05/03.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

struct Resource<T:Decodable> {
  let url: URL
}

extension URLRequest {
//  static func load<T>(resource: Resource<T>) -> Observable<T?> {
//    return Observable.from( [resource.url] )
//      .flatMap { url -> Observable<Data> in
//      let request = URLRequest(url: url)
//      return URLSession.shared.rx.data(request: request)
//      }.map { data -> T? in
//        return try? JSONDecoder().decode(T.self, from: data)
//    }.asObservable()
//  }
  
  static func load<T>(resource: Resource<T>) -> Observable<T?> {
    return Observable
      .just(resource.url)
      .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
      let request = URLRequest(url: url)
      return URLSession.shared.rx.response(request: request)
      }.map {response, data -> T in
        if 200..<300 ~= response.statusCode {
          return try JSONDecoder().decode(T.self, from: data)
        } else {
          throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
        }
    }.asObservable()
  }
}
