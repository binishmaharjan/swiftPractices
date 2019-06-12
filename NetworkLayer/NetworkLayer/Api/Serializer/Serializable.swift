//
//  Serializable.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

/*
 APITypeの項で全てのAPIはHTTPのレスポンスのData型のobjectを特定の型のmodelへ変換する
 
 protocol Serializableではdataを受け取りgenericな指定された型を返すfunctionが定義されている。
 */

protocol Serializable {
  
  associatedtype SerializingType
  static func serialize(data: Data) -> SerializingType?
  
}
