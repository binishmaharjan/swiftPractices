//
//  UITableView+Extension.swift
//  TableViewWithEnum
//
//  Created by Maharjan Binish on 2019/11/03.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

extension UITableView {
  
  func registerXib<Cell: UITableViewCell & XibLoadable>(of cellClass: Cell.Type, with cellIdentifier: String = Cell.xibName) {
    register(cellClass.xib, forCellReuseIdentifier: cellIdentifier)
  }
  
  func dequeue<Cell: UITableViewCell & XibLoadable>(_ cell: Cell.Type, for indexPath: IndexPath, with cellIdentifier: String = Cell.xibName) -> Cell {
    guard let cell = dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell else {
      fatalError()
    }
    
    return cell
  }
}
