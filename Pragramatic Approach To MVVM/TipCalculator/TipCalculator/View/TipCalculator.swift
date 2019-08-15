//
//  TipCalculator.swift
//  TipCalculator
//
//  Created by Maharjan Binish on 2019/08/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class TipCalculator: UIViewController {

  @IBOutlet weak var totalAmount: UITextField!
  @IBOutlet weak var tipPercentage: UISegmentedControl!
  @IBOutlet weak var numberOfPeople: UITextField!
  
  @IBOutlet weak var newTotalLabel: UILabel!
  @IBOutlet weak var tipAmountLabel: UILabel!
  
  var viewModel = TipViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }
  
  private func setup() {
    self.totalAmount.text = ""
    self.numberOfPeople.text = ""
    
    self.totalAmount.keyboardType = .decimalPad
    self.numberOfPeople.keyboardType = .numberPad
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnScreen(_:)))
    self.view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func didTapOnScreen(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
    
    let totalAmount = self.totalAmount.text?.toDouble ?? 0.0
    let tipPercentage = self.tipPercentage.titleForSegment(at: self.tipPercentage.selectedSegmentIndex)?.toDouble ?? 0.0
    let numberOfPeople = self.numberOfPeople.text?.toDouble ?? 1.0
    
    let tip = Tip(totalAmount: totalAmount, tipPercentage: tipPercentage, numberOfPeople: numberOfPeople)
    let payingAmount = viewModel.calculateTip(tip: tip)
    
    newTotalLabel.text = "Total amount: \(payingAmount.amount)"
    newTotalLabel.text?.append((tip.numberOfPeople > 1 ? " per person" : ""))
    
    tipAmountLabel.text = "Tip amount: \(payingAmount.tipAmount)"
    tipAmountLabel.text?.append((tip.numberOfPeople > 1 ? " per person" : ""))
  }
}

