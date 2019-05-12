//
//  Articles.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/05/02.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

struct ArticlesList: Decodable {
  let articles: [Article]
}

struct Article: Decodable {
  let title: String
  let description: String?
}

struct ArticleResponse: Decodable {
  let articles: [Article]
}
