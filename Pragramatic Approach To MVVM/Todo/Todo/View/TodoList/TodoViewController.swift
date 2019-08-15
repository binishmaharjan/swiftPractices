//
//  TodoViewController.swift
//  Todo
//
//  Created by Maharjan Binish on 2019/08/05.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private var viewModel = TodoViewModel()
  private var datasource: TodoListDataSourceDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }
  
  private func setup() {
    self.datasource = TodoListDataSourceDelegate(viewModel: viewModel)
    datasource.delegate = self
    self.tableView.delegate = self.datasource
    self.tableView.dataSource = self.datasource
    self.tableView.estimatedRowHeight = 100
    self.tableView.rowHeight = UITableView.automaticDimension
  }
  
  
  @IBAction func addButtonPressed(_ sender: Any) {
    let addViewController = TodoAddViewController.loadStoryboard()
    addViewController.delegate  = self
    self.navigationController?.pushViewController(addViewController, animated: true)
  }
}

extension TodoViewController: TodoAddNewItemProtocol {
  func didAddNewItem(viewModel: TodoAddViewModel) {
    guard let todo = viewModel.newTodo else { return }
    self.viewModel.addNew(todo: todo)
    self.tableView.reloadData()
  }
}


extension TodoViewController : TodoItemTappedDelegate {
  func setCompletedState(index: Int, completion: @escaping () -> Void) {
    let alertController = UIAlertController(title: "Mark Completion",
                                            message: "Mark this item as completed",
                                            preferredStyle: .alert)
    
    let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
      self.viewModel.updateCompletion(at: index, newValue: true)
      completion()
    }
    
    let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
    
    alertController.addAction(yesAction)
    alertController.addAction(noAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
}
