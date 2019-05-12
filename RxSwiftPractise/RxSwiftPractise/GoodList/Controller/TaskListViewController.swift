//
//  TaskListViewController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/04/30.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
  
  
  @IBOutlet weak var prioritySegementControl: UISegmentedControl!
  @IBOutlet weak var tableViewControl: UITableView!
  
  private let disposeBag = DisposeBag()
  private var tasks = BehaviorRelay<[Task]>(value: [Task]())
  private var filterTasks = [Task]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewControl.delegate = self
    tableViewControl.dataSource = self
  }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.filterTasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? UITableViewCell {
      cell.textLabel?.text = filterTasks[indexPath.row].title
      return cell
    }
  }
}

extension TaskListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let navVC = segue.destination as? UINavigationController,
          let addVC = navVC.viewControllers.first as? AddTaskViewController
    else { fatalError("ERROR") }
    
    addVC.taskSubjectObservable.subscribe(onNext: { [unowned self] task in
      let priority = Priority(rawValue: self.prioritySegementControl.selectedSegmentIndex - 1)
      
      var existingTask = self.tasks.value
      existingTask.append(task)
      self.tasks.accept(existingTask)
      
      self.filterTask(by: priority)
  
    }).disposed(by: disposeBag)
  }
  
  private func filterTask(by priority: Priority?) {
    guard let priority = priority else {
      self.filterTasks = self.tasks.value
      self.updateTableView()
      return
    }
    
    self.tasks.map { tasks in
      return tasks.filter { $0.priority == priority }
      }.subscribe(onNext: { [unowned self] tasks in
        self.filterTasks = tasks
        self.updateTableView()
      }).disposed(by: disposeBag)
    
    /*
     'BehaviourRelay<Task>().map' results in 'Observable<()>'.
     Here 'a' is of type 'Observable<()>'  and the task is of type '[Task]()'
     since it is maping out 'tasks' value.
     
     /- Code -/
     let a = self.tasks.map { tasks in
     }
     */
    
    /*
     Returning the '[Task]()' inside map gives the genric type to the 'Observable<()>'.
     'a' becomes 'Observable<[Task]>' from 'Observable<()>'.
     
     /- Code -/
     let a = self.tasks.map { tasks in
        return tasks.filter { $0.priority == priority }
     }
     */
    
  }
  
  private func updateTableView() {
    DispatchQueue.main.async {
      self.tableViewControl.reloadData()
    }
  }
  
  @IBAction func priorityValueChanged(segementControl: UISegmentedControl) {
    let priority = Priority(rawValue: segementControl.selectedSegmentIndex - 1)
    self.filterTask(by: priority)
  }
}
