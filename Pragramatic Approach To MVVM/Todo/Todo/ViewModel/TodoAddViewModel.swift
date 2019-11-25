//
//  TodoAddViewModel.swift
//  Todo
//
//  Created by Maharjan Binish on 2019/08/06.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

class TodoAddViewModel {
  
  private var todoItem: Todo?
  
  var newTodo: Todo? {
    get { return todoItem }
    set { todoItem = newValue }
  }
  
}
