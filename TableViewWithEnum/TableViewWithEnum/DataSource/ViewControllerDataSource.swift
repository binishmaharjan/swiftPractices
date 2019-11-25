//
//  ViewControllerDataSource.swift
//  TableViewWithEnum
//
//  Created by Maharjan Binish on 2019/11/03.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class ViewControllerDataSource: NSObject {
  
  // MARK: - Section Types
  enum SectionType: CaseIterable {
    case section1
    case section2
    case section3
    
    var rowCount: Int {
      switch self {
      case .section1:
        return Section1RowType.allCases.count
      case .section2:
        return Section2RowType.allCases.count
      case .section3:
        return Section3RowType.allCases.count
      }
    }
    
    var headerHeight: CGFloat {
      return 20
    }
    
    var rowHeight: CGFloat {
      return 44
    }
    
  }
  
  // MARK: - Section 1 Row Types
  enum Section1RowType: CaseIterable {
    case row1
    case row2
    case row3
    
    var title: String {
      switch self {
      case .row1:
        return "Section 1 - Row 1"
      case .row2:
        return "Section 1 - Row 2"
      case .row3:
        return "Section 1 - Row 3"
      }
    }
  }
  
  // MARK: - Section 2 Row Types
  enum Section2RowType: CaseIterable {
    case row1
    case row2
    
    var title: String {
      switch self {
      case .row1:
        return "Section 2 - Row 1"
      case .row2:
        return "Section 2 - Row 2"
      }
    }
  }
  
  // MARK: - Section 3 Row Types
  enum Section3RowType: CaseIterable {
    case row1
    
    var title: String {
      switch self {
      case .row1:
        return "Section 3 - Row 1"
      }
    }
  }
  
  // MARK: - Properties
  let sectionType = SectionType.allCases.map { $0 }
  let section1RowType = Section1RowType.allCases.map { $0 }
  let section2RowType = Section2RowType.allCases.map { $0 }
  let section3RowType = Section3RowType.allCases.map { $0 }
  
}

// MARK: - Table View Delegate
extension ViewControllerDataSource: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return self.sectionType[section].headerHeight
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.sectionType[indexPath.section].rowHeight
  }
  
}

// MARK: - Table View DataSource
extension ViewControllerDataSource: UITableViewDataSource {
  
 func numberOfSections(in tableView: UITableView) -> Int {
    return sectionType.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sectionType[section].rowCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(Cell.self, for: indexPath)
    
    switch sectionType[indexPath.section] {
    case .section1:
      let title = section1RowType[indexPath.row].title
      cell.set(title)
    case .section2:
      let title = section2RowType[indexPath.row].title
      cell.set(title)
    case .section3:
      let title = section3RowType[indexPath.row].title
      cell.set(title)
    }
    
    return cell
  }
  
}
