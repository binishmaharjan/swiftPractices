//
//  TodoViewModel.swift
//  Todo
//
//  Created by Maharjan Binish on 2019/08/05.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

class TodoViewModel {
  
  var todos: [Todo]
  var count: Int {
     return todos.count
  }
  
  init() {
    self.todos = [Todo]()
  }
  
  func item(at index: Int) -> Todo {
    return self.todos[index]
  }
  
  func updateCompletion(at index: Int, newValue: Bool) {
    self.todos[index].completed = newValue
  }
  
  func addNew(todo: Todo) {
    self.todos.append(todo)
  }
}
