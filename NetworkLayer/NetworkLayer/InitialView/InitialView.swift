//
//  InitialView.swift
//  NetworkLayer
//
//  Created by Maharjan Binish on 2019/06/12.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit

class InitialView: UIView {
  
  @IBOutlet weak var displayTextView: UITextView!
  @IBOutlet weak var startButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @IBAction func startButtonPressed(_ sender: Any) {
    self.fetchCharacters()
  }
  
}

extension InitialView: HasXib {}

extension InitialView {
  private func fetchCharacters() {
    CharacterApi.all.dispatch(dispatcher: URLSessionRequestDispatcher(),
                              onSuccess: { (characters) in
                                var result = ""
                                characters.characters.forEach({ (character) in
                                  result.append(contentsOf: "Mal Id : \(character.malId)\n")
                                  result.append(contentsOf: "Name : \(character.name)\n")
                                  result.append(contentsOf: "Role : \(character.role)\n")
                                  result.append(contentsOf: "---------------------------\n")
                                })
                                self.displayTextView.text = result
    },
                              onError: { error in
                                self.displayTextView.text = error.localizedDescription
                                print("Error: \(error)")
    })
  }
}
