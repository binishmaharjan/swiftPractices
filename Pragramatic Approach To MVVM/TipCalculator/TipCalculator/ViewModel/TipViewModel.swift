//
//  TipViewModel.swift
//  TipCalculator
//
//  Created by Maharjan Binish on 2019/08/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

struct PayingAmount {
  var amount: Double
  var tipAmount: Double
}

class TipViewModel {
  func calculateTip(tip: Tip) -> PayingAmount {
    let tipAmount = tip.totalAmount * tip.tipPercentage / 100
    let newTotal = tip.totalAmount + tipAmount
    let perPersonAmount = newTotal / tip.numberOfPeople
    let perPersonTip = tipAmount / tip.numberOfPeople
    return PayingAmount(amount: perPersonAmount,tipAmount: perPersonTip)
  }
  
}
