//
//  RequestDispatchable.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

/*
 
 APIType+dispatchのdispatchメソッドの部分でDispatcherをDI可能にするためのprotocol。
 
 */

protocol RequestDispatchable {
  func dispatch(request: Request,
                onSuccess: @escaping (Data) -> Void,
                onError: @escaping (Error) -> Void)
}
