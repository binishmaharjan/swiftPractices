//
//  HasStoryboard.swift
//  Todo
//
//  Created by Maharjan Binish on 2019/08/06.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

protocol HasStoryboard {
  static var storyboardName: String { get }
  static var viewControllerName: String { get }
}

extension HasStoryboard where Self: UIViewController {
  static func loadStoryboard() -> Self {
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as! Self
    return viewController
  }
}
