//
//  ApiType.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit


/*
 Swiftプロジェクトにおいて定義されるAPIは主に２つの責務を担っている。
 - HTTPリクエストを送信すること、
 - 帰ってきたレスポンンスからModel等のデータをパースして取り出すことである。
 
 */

protocol APIType {
  associatedtype ResponseType
  
  var request: Request { get }
  var responseSerializer: ResponseSerializer { get }
}


