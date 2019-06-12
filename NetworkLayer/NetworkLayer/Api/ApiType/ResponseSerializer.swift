//
//  ResponseSerializer.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

/*
 
 HTTPリクエストから帰ってきたレスポンスをmodelに変換する部分
 
 */

extension APIType {
  typealias ResponseSerializer = ((Data) -> (ResponseType?))
}
