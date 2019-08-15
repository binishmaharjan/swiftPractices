//
//  TodoAddViewController.swift
//  Todo
//
//  Created by Maharjan Binish on 2019/08/05.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

protocol TodoAddNewItemProtocol: class {
  func didAddNewItem(viewModel: TodoAddViewModel)
}

class TodoAddViewController: UIViewController {
  
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var notesTextField: UITextField!
  
  private var viewModel = TodoAddViewModel()
  weak var delegate: TodoAddNewItemProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func saveButtonWasPressed(_ sender: Any) {
    let todo = Todo(task: taskTextField.text!, completed: false, notes: notesTextField.text!)
    self.viewModel.newTodo = todo
    self.delegate?.didAddNewItem(viewModel: viewModel)
    self.navigationController?.popViewController(animated: true)
  }
}

extension TodoAddViewController: HasStoryboard {
  static var storyboardName: String { return "TodoAdd" }
  static var viewControllerName: String { return "addViewController" }
}
