//
//  PhotosCollectionViewController.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/04/29.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import UIKit
import Photos
import RxSwift

class PhotosCollectionViewController: UICollectionViewController {
  var images = [PHAsset]()
  
  //Observable
  private let selectedImageSubject = PublishSubject<UIImage>()
  var selectedPhoto: Observable<UIImage> {
    return selectedImageSubject.asObservable()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.populatePhotoLibrary()
  }
  
  private func populatePhotoLibrary() {
    PHPhotoLibrary.requestAuthorization { [weak self] (status) in
      if status == .authorized {
        let assests = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assests.enumerateObjects{ (object, count, stop) in
          self?.images.append(object)
        }
        self?.images.reverse()
        DispatchQueue.main.async {
           self?.collectionView.reloadData()
        }
      }
    }
  }
}

extension PhotosCollectionViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell{
      
      let assest = images[indexPath.row]
      let manager = PHImageManager.default()
      manager.requestImage(for: assest, targetSize: .init(width: 100, height: 100), contentMode: .aspectFit, options: nil) { (image, _) in
        DispatchQueue.main.async {
          cell.photoImageView.image = image
        }
      }
      return cell
    }
    return UICollectionViewCell()
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedAssest = images[indexPath.row]
    PHImageManager.default().requestImage(for: selectedAssest, targetSize: .init(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] (image, info) in
      guard let info = info else { return }
      let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
      if !isDegradedImage {
        if let image = image {
          self?.selectedImageSubject.onNext(image)
          self?.dismiss(animated: true, completion: nil)
        }
      }
    }
  }
  
}
