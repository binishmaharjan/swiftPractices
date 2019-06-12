//
//  FourthViewController.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/06/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
  
  enum Row {
    case entireUser
    case user(User)
  }
  
  struct Section {
    let rows: [Row]
  }
  
  private let fourthView = FourthView.loadXib()
  private let rowHeight: CGFloat = 45
  
  //Table View Property
  //All Actual table Data
  var userSelectState = UserSelectState(allFriends: [
    User(name: "Naruto", age: 29),
    User(name: "Sasuke", age: 30),
    User(name: "Sakura", age: 30),
    User(name: "Hinata", age: 28),
    User(name: "Kakashi", age: 50),
    ])
  //Closure to be executed After selecting needed Users
  var renewedUserSelectState: ((UserSelectState) -> Void)?
  //For Rendering tableview
  var tableViewSections: [Section] {
    let section = [
      Section(rows: [Row.entireUser]),
      Section(rows: userSelectState.allFriends.map {Row.user($0)})
    ]
    return section
  }
  
  override func loadView() {
    self.view = fourthView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFourthView()
  }
  
  private func setupFourthView() {
    fourthView.tableView.register(FourthCell.loadNib(), forCellReuseIdentifier: FourthCell.xibName)
    fourthView.tableView.delegate = self
    fourthView.tableView.dataSource = self
  }
}

extension FourthViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewSections.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewSections[section].rows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FourthCell.xibName, for: indexPath) as? FourthCell else {
      preconditionFailure()
    }
    cell.tintColor = UIColor(named: "mainPurple")
    switch self.row(for: indexPath) {
    case .entireUser:
      reloadEntireUserCell(cell, indexPath: indexPath)
    case .user(let user):
      reloadFriendCell(cell, indexPath: indexPath, user: user)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    switch self.row(for: indexPath) {
    case .entireUser:
      userSelectState.deselectAllUsers()
    case .user(let user):
      userSelectState.selectOrDeselect(user)
    }
    
    let visibleIndexPath = tableView.indexPathsForVisibleRows ?? []
    let visibleCell = tableView.visibleCells as! [FourthCell]
    zip(visibleIndexPath, visibleCell).forEach { (indexPath, cell) in
      reloadCell(cell, indexPath: indexPath)
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 45))
    headerView.backgroundColor = .gray
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeight
  }
  
  func row(for indexPath: IndexPath) -> Row {
    return tableViewSections[indexPath.section].rows[indexPath.row]
  }
  
  func reloadCell(_ cell: FourthCell, indexPath: IndexPath) {
    switch self.row(for: indexPath) {
    case .entireUser:
      reloadEntireUserCell(cell, indexPath: indexPath)
    case .user(let user):
      reloadFriendCell(cell, indexPath: indexPath, user: user)
    }
  }
  
  func reloadEntireUserCell(_ cell: FourthCell, indexPath: IndexPath) {
    cell.userLabel.text = "All"
    if userSelectState.selectFriends.isEmpty {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
  }
  
  func reloadFriendCell(_ cell: FourthCell, indexPath: IndexPath, user: User) {
    cell.userLabel.text = user.name
    if userSelectState.isSelecting(user){
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
  }
 
}
