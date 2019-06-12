//
//  UserSelectState.swift
//  TableViewPractise
//
//  Created by Maharjan Binish on 2019/06/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

struct UserSelectState {
  let allFriends: [User]
  private(set) var selectFriends: [User] = []
  
  init(allFriends: [User]) {
    self.allFriends = allFriends
  }
  
  init(allFriends: [User], selectFriends:[User]) {
    self.allFriends = allFriends
    self.selectFriends = selectFriends
  }
  
  func isSelecting(_ user: User) -> Bool {
    return selectFriends.contains(user)
  }
  
  mutating func selectOrDeselect(_ user: User) {
    if let index = selectFriends.firstIndex(of: user) {
      selectFriends.remove(at: index)
    } else {
      selectFriends.append(user)
    }
  }
  
  mutating func deselectAllUsers() {
    selectFriends.removeAll()
  }
}
