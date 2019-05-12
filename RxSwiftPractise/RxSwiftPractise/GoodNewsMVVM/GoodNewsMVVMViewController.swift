//
//  GoodNewsMVVMViewController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/05/09.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GoodNewsMVVMViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private var articleListMV: ArticleListViewModal!
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    self.populateNews()
  }
  
  private func populateNews() {
    let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0a4dadaaefb34d6a9a1d48c08045f302")!)
    
    URLRequest.load(resource: resource)
      .subscribe(onNext: {
        if let articles = $0?.articles {
          self.articleListMV = ArticleListViewModal(articles)
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
        }
    }).disposed(by: disposeBag)
  }
}

extension GoodNewsMVVMViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articleListMV == nil ? 0 : self.articleListMV.articleVM.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "gnmvvmcell", for: indexPath) as? ArticleTableViewCell {
      let articleVM = self.articleListMV.articleAt(indexPath.row)
      
      articleVM
        .title
        .asDriver(onErrorJustReturn: "")
        .drive(cell.titleLabel.rx.text)
        .disposed(by: disposeBag)
      
      articleVM
        .description
        .asDriver(onErrorJustReturn: "")
        .drive(cell.descriptionLabel.rx.text)
        .disposed(by: disposeBag)
      
      return cell
    }
    return UITableViewCell()
  }
}
