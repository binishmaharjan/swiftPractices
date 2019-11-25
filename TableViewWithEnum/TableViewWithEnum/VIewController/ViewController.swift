//
//  ViewController.swift
//  TableViewWithEnum
//
//  Created by Maharjan Binish on 2019/11/03.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  private var dataSource = ViewControllerDataSource()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }
  
  // MARK: - Methods
  private func setup() {
    self.tableView.dataSource = dataSource
    self.tableView.delegate = dataSource
    
    self.tableView.registerXib(of: Cell.self)
  }
    
}
