//
//  ArticleViewModal.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/05/09.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct ArticleListViewModal {
  let articleVM: [ArticleViewModal]
  
  init(_ articles: [Article]) {
    self.articleVM = articles.compactMap(ArticleViewModal.init)
  }
}

extension ArticleListViewModal {
  func articleAt(_ index: Int) -> ArticleViewModal {
    return self.articleVM[index]
  }
}

struct ArticleViewModal {
  let article: Article
  
  init(_ article: Article) {
    self.article = article
  }
}

extension ArticleViewModal {
  var title: Observable<String> {
    return Observable<String>.just(article.title)
  }
  
  var description: Observable<String> {
    return Observable<String>.just(article.description ?? "")
  }
}
