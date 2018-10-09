//
//  NASAAPIClient.swift
//  NASApp
//
//  Created by Michele Mola on 06/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import Foundation
import CoreLocation

class NASAAPIClient: APIClient {
  internal let session: URLSession
  
  private let apiKey = "sfRLeTN4tXOMNkzyO41cus9MivpoU3toTvuWA8Fw"
  
  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  convenience init() {
    self.init(configuration: .default)
  }
  
  typealias MarsPhotosCompletionHandler = (Response<MarsRoverPhotos?, APIError>) -> Void
  func getMarsPhotos(completion: @escaping MarsPhotosCompletionHandler) {
    
    let request = NASA.marsPhotos(apiKey: apiKey, page: 1, sol: 1000).request
    
    fetch(with: request, decode: { json -> MarsRoverPhotos? in
      guard let photos = json as? MarsRoverPhotos else { return nil }
      return photos
    }, completion: completion)
  }
  
  typealias EarthPhotoCompletionHandler = (Response<EarthPhoto?, APIError>) -> Void
  func getEarthPhoto(byCoordinate coordinate: CLLocationCoordinate2D, completion: @escaping EarthPhotoCompletionHandler) {
    
    let request = NASA.earthPhoto(apiKey: apiKey, lat: coordinate.latitude, lon: coordinate.longitude).request
    
    fetch(with: request, decode: { json -> EarthPhoto? in
      guard let earthPhoto = json as? EarthPhoto else { return nil }
      return earthPhoto
    }, completion: completion)
  }
  
}
