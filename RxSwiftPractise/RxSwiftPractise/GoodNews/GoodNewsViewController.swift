//
//  GoodNewsViewController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/05/02.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GoodNewsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var articles = [Article]()
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    self.populateNews()
  }
  
  private func populateNews() {
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0a4dadaaefb34d6a9a1d48c08045f302")!
    
    let resources = Resource<ArticlesList>(url: url)
    URLRequest.load(resource: resources)
      .subscribe(onNext: { [unowned self] result in
      if let result = result {
        self.articles = result.articles
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }).disposed(by: disposeBag)
  }
}

extension GoodNewsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
      cell.titleLabel.text = self.articles[indexPath.row].title
      cell.descriptionLabel.text = self.articles[indexPath.row].title
      return cell
    }
    
    return UITableViewCell()
  }
  
  
}
