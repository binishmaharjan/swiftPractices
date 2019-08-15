//
//  TodoCell.swift
//  Todo
//
//  Created by Maharjan Binish on 2019/08/05.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
  
  @IBOutlet weak var taskName: UILabel!
  @IBOutlet weak var taskNote: UILabel!
  
  var todo: Todo? {
    didSet {
      guard let todo = todo else { return }
      self.populateData(todo: todo)
    }
  }

  private func populateData(todo: Todo) {
    switch todo.completed {
    case true:
      self.accessoryType = .checkmark
      self.taskName.attributedText = todo.task.strikeThrough
      self.taskNote.attributedText = todo.notes.strikeThrough
    case false:
      self.accessoryType = .none
      self.taskName.text = todo.task
      self.taskNote.text = todo.notes
    }
  }
  
}
