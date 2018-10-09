//
//  MarsPhotosCollectionViewController.swift
//  NASApp
//
//  Created by Michele Mola on 06/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit

class MarsPhotosCollectionViewController: UICollectionViewController {
  
  let client = NASAAPIClient()
  
  lazy var dataSource: MarsRoverListDataSource = {
    return MarsRoverListDataSource(marsRoverPhotos: [])
  }()
  
  var marsRoverPhotos: [MarsRover] = [] {
    didSet {
      self.dataSource.update(with: marsRoverPhotos)
      self.collectionView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = dataSource
    
    getMarsRoverPhotos()
  }
  
  func getMarsRoverPhotos() {
    client.getMarsPhotos { response in
      switch response {
      case .success(let marsRoverPhotos):
        guard let marsRoverPhotos = marsRoverPhotos else { return }
        self.marsRoverPhotos = marsRoverPhotos.photos
      case .failure(let error):
        print(error)
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let roverPostcardMakerViewController = segue.destination as? RoverPostcardMakerViewController {
        if let indexPath = collectionView.indexPathsForSelectedItems?.first {
          let marsRover = dataSource.marsRover(at: indexPath)
          roverPostcardMakerViewController.marsRover = marsRover
        }
      }
    }
  }

  
  
}

extension MarsPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (collectionView.frame.width / 2) - 5
    return CGSize(width: width, height: width)
  }
}
