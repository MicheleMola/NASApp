//
//  MarsRoverPhotoCell.swift
//  NASApp
//
//  Created by Michele Mola on 06/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import UIKit
import Kingfisher

class MarsRoverPhotoCell: UICollectionViewCell {
  static let reuseIdentifier = "MarsRoverPhotoCell"
  
  @IBOutlet weak var marsRoverImageView: UIImageView!
  
  func configure(withMarsRoverPhoto marsRoverPhoto: MarsRover) {
    marsRoverImageView.kf.setImage(with: marsRoverPhoto.img_src, placeholder: UIImage(named: "placeholder.png"))
  }

}
