//
//  Endpoint.swift
//  NASApp
//
//  Created by Michele Mola on 06/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import Foundation

protocol Endpoint {
  var base: String { get }
  var path: String { get }
  var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
  var urlComponents: URLComponents {
    var components = URLComponents(string: base)!
    components.path = path
    components.queryItems = queryItems
    
    return components
  }
  
  var request: URLRequest {
    let url = urlComponents.url!
    return URLRequest(url: url)
  }
}

enum NASA {
  case marsPhotos(apiKey: String, page: Int, sol: Int)
}

extension NASA: Endpoint {
  var base: String {
    return "https://api.nasa.gov"
  }
  
  var path: String {
    switch self {
    case .marsPhotos: return "/mars-photos/api/v1/rovers/curiosity/photos"
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    case .marsPhotos(let apiKey, let page, let sol):
      return [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "page", value: "\(page)"),
        URLQueryItem(name: "sol", value: "\(sol)")
      ]
    }
  }
}
