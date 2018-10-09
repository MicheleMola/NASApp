//
//  MarsPhotosListDataSource.swift
//  NASApp
//
//  Created by Michele Mola on 06/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit

class MarsRoverListDataSource: NSObject, UICollectionViewDataSource {
  
  private var marsRoverPhotos: [MarsRover]
  
  init(marsRoverPhotos: [MarsRover]) {
    self.marsRoverPhotos = marsRoverPhotos
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return marsRoverPhotos.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let marsRoverPhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: MarsRoverPhotoCell.reuseIdentifier, for: indexPath) as! MarsRoverPhotoCell
    
    let marsRoverPhoto = marsRoverPhotos[indexPath.row]
    
    marsRoverPhotoCell.configure(withMarsRoverPhoto: marsRoverPhoto)
    
    return marsRoverPhotoCell
  }
  
  func update(with marsRoverPhotos: [MarsRover]) {
    self.marsRoverPhotos = marsRoverPhotos
  }
  
  func marsRover(at indexPath: IndexPath) -> MarsRover {
    return marsRoverPhotos[indexPath.row]
  }
}
