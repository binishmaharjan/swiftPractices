//
//  CameraFilterViewController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/04/28.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CameraFilterViewController: UIViewController {
  
  @IBOutlet weak var applyFilterButton: UIButton!
  @IBOutlet weak var photoImageView: UIImageView!
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let navVC = segue.destination as? UINavigationController,
      let photoVC = navVC.viewControllers.first as? PhotosCollectionViewController else {
        fatalError("Wrong Destination")
    }
    photoVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
      DispatchQueue.main.async {
        self?.updateUI(photo: photo)
      }
    }).disposed(by: disposeBag)
    
  }
  
  private func updateUI(photo: UIImage) {
    self.photoImageView.image = photo
    self.applyFilterButton.isHidden = false
  }
  
  @IBAction func applyFilterButtonPressed(_ sender: Any) {
    guard let sourceImage = photoImageView.image else { return }
    FilterService().applyFilter(to: sourceImage)
      .subscribe(onNext: { filteredImage in
      DispatchQueue.main.async {
        self.photoImageView.image = filteredImage
      }
    }).disposed(by: disposeBag)
  }
}
