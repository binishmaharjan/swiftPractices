//
//  SimpleListViewModel.swift
//  SimpleMMVM
//
//  Created by Maharjan Binish on 2019/08/03.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation


class SimpleListViewModel {
  
  private var simpleModels: [SimpleModel]
  
  var count: Int {
    return simpleModels.count
  }
  
  init() {
    simpleModels = [
      SimpleModel(text: "Orange", color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
      SimpleModel(text: "Blue", color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
      SimpleModel(text: "Green", color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)),
      SimpleModel(text: "Purple", color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
      SimpleModel(text: "Cyan", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    ]
  }
  
  func simpleModel(at index: Int) -> SimpleModel {
    return simpleModels[index]
  }
}
