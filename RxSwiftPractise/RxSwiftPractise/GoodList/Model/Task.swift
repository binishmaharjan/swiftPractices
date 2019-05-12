//
//  Task.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/04/30.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

enum Priority: Int {
  case high
  case medium
  case low
}

struct Task {
  let title: String
  let priority: Priority
}
