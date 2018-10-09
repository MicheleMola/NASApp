//
//  DataDownloaded.swift
//  NASAppTests
//
//  Created by Michele Mola on 09/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import XCTest
import UIKit
import CoreLocation
import Kingfisher
@testable import NASApp

class DataDownloaded: XCTestCase {
  
  let client = NASAAPIClient()
  
  let imageView = UIImageView()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testMarsRover() {
    client.getMarsPhotos() { response in
      switch response {
      case .success(let marsRover):
        XCTAssert(marsRover?.photos != nil, "Mars rover photos is nil")
      case .failure(let error):
        XCTFail("Error: \(error.localizedDescription)")
      }
    }
  }
  
  func testEarthPhoto() {
    
    let latitude = 33.345
    let longitude = 77.63
    
    if !(latitude >= -90 && latitude <= 90) || !(longitude >= -180 && longitude <= 180) {
      XCTFail("Invalid latitude or longitude")
    }
    
    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    
    client.getEarthPhoto(byCoordinate: coordinate) { response in
      switch response {
      case .success(let earthPhoto):
        XCTAssert(earthPhoto?.url != nil, "Earth photo url is nil")
      case .failure(let error):
        XCTFail("Error: \(error.localizedDescription)")
      }
      
    }
  }
  
  func testImageDownloader() {
    let url = URL(string: "https://earthengine.googleapis.com/api/thumb?thumbid=0d15ad8d2af6d8d0a6b083672514fae7&token=6d3f8c22536ab26f3563d64ce851e56c")
    imageView.kf.setImage(with: url) { (image, error, cacheType, imageUrl) in
      XCTAssert(error != nil, "Download image error")
    }
  }
  
}
