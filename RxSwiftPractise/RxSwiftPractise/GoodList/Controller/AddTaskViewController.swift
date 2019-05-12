//
//  AddTaskViewController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/04/30.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
  
  @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
  @IBOutlet weak var taskTitleTextField: UITextField!
  
  private let taskSubject = PublishSubject<Task>()
  var taskSubjectObservable: Observable<Task> {
    return taskSubject.asObservable()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func saveButtonClicked(_ sender: Any) {
    guard let priority = Priority(rawValue: prioritySegmentControl.selectedSegmentIndex),
      let title = taskTitleTextField.text
    else { return }
    
    let task = Task(title: title, priority: priority)
    taskSubject.onNext(task)
    self.dismiss(animated: true, completion: nil)
  }
}
