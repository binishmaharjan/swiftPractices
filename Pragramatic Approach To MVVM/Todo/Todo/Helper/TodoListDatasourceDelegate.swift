//
//  TodoListDatasourceDelegate.swift
//  Todo
//
//  Created by Maharjan Binish on 2019/08/05.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

protocol TodoItemTappedDelegate: class {
  func setCompletedState(index: Int, completion: @escaping () -> Void)
}

class TodoListDataSourceDelegate: NSObject {
  var viewModel: TodoViewModel
  weak var delegate: TodoItemTappedDelegate? = nil
  
  init(viewModel: TodoViewModel) {
    self.viewModel = viewModel
  }
}

extension TodoListDataSourceDelegate: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.delegate?.setCompletedState(index: indexPath.item, completion: {
      tableView.reloadRows(at: [indexPath], with: .automatic)
    })
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension TodoListDataSourceDelegate: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoCell
    cell.todo = viewModel.item(at: indexPath.item)
    return cell
  }
}
