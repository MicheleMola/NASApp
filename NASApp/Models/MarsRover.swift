//
//  Mars.swift
//  NASApp
//
//  Created by Michele Mola on 06/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import Foundation

struct MarsRover: Codable {
  let id: Int
  let img_src: URL
}

struct MarsRoverPhotos: Codable {
  let photos: [MarsRover]
}
