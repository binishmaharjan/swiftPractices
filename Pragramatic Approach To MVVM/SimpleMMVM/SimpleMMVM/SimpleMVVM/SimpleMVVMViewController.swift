//
//  SimpleMVVMViewController.swift
//  SimpleMMVM
//
//  Created by Maharjan Binish on 2019/08/03.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class SimpleMVVMViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private var viewModel = SimpleListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()

  }
  
  private func setup() {
    self.title = "Simple MVVM"
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
  }
  
}


extension SimpleMVVMViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SimpleMVVMCell
    cell.data = viewModel.simpleModel(at: indexPath.row)
    return cell
  }
  
}

extension SimpleMVVMViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90
  }
  
}
