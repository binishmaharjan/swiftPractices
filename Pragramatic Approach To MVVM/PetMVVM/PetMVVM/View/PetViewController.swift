//
//  PetViewController.swift
//  PetMVVM
//
//  Created by Maharjan Binish on 2019/08/06.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class PetViewController: UIViewController {
  
  private var petView: PetView { return self.view as! PetView }
  private var viewModel: PetViewModel!
  
  override func loadView() {
    self.view = PetView.loadXib()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViewModel()
    self.viewModel.configure(view: petView)
  }
  
  private func setupViewModel() {
    let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 366))
    let pet = Pet(name: "New Pet", birthday: birthday, rarity: .veryRare, image: "IMG_01")
    self.viewModel = PetViewModel(pet: pet)
  }
}
