//
//  SecondViewController.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/23.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  
  enum Row {
    case all
    case user(User)
  }
  
  struct Section {
    let row: [Row]
  }
  
  let mainView = SecondView.loadXib()
  let sections = [
    Section(row: [Row.all])
  ]
  
  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.mainView.tableView.delegate = self
    self.mainView.tableView.dataSource = self
    self.mainView.tableView.estimatedSectionFooterHeight = 127
    self.mainView.tableView.register(SecondCell.loadNib(), forCellReuseIdentifier: SecondCell.xibName)
  }
  
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].row.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SecondCell.xibName, for: indexPath) as! SecondCell
    cell.selectionStyle = .default
    cell.selectionColor = UIColor.blue.withAlphaComponent(0.1)
    cell.accessoryType = .checkmark
    cell.tintColor = .purple
    
    switch row(for: indexPath) {
    case .all:
      cell.secondLabel.text = "All"
    case .user(let user):
      cell.secondLabel.text = user.name
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    if sections.count == 1 {
      let view = EmptyView.loadXib()
      return view
    }
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 127
  }

  private func row(for index: IndexPath) -> Row {
    return sections[index.section].row[index.row]
  }
  
}
