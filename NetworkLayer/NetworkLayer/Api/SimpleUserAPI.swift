//
//  SimpleUserAPI.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//


/*
 
 https://qiita.com/EnVacance/items/3ac70909f8f2c49e7ae9#baseapi
 
 */
import Foundation

struct SimpleCharacterApi: APIType {
  typealias ResponseType = Characters
  
  var request: Request = Request(url: "https://api.jikan.moe/v3/manga/2/characters",
                                 method: .get,
                                 params: nil,
                                 headers: nil)
  
  var responseSerializer: ((Data) -> (Characters?)) = CodableSerializer<Characters>.serialize
 
}
