//
//  FirstView.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/05/22.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class FirstView: UIView {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setup()
  }
  
  private func setup() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FirstCell.loadNibCell(), forCellReuseIdentifier: FirstCell.xibName)
  }
}

extension FirstView: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: FirstCell.xibName) as? FirstCell {
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView(frame: .init(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
    headerView.backgroundColor = UIColor.purple
    return headerView
  }
  
}


extension FirstView: HasXib {}

protocol HasXib {}
extension HasXib where Self: UIView {
  
  static private var xibName: String {
    return String(describing: Self.self)
  }
  
  static func loadXib() -> Self {
    let nibs = UINib(nibName: xibName, bundle: nil).instantiate(withOwner: self, options: nil)
    guard let theSelf = nibs.first as? Self else {
      preconditionFailure("Ahhhhhhhh")
    }
    return theSelf
  }
}

extension HasXib where Self: UITableViewCell{
  
  static var xibName: String {
    return String(describing: Self.self)
  }
  
  static func loadNibCell() -> UINib {
    let nib = UINib(nibName: xibName, bundle: nil)
    return nib
  }
}
