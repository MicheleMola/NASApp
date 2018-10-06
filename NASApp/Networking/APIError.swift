//
//  APIError.swift
//  NASApp
//
//  Created by Michele Mola on 06/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import Foundation

enum APIError: String, Error {
  case requestFailed = "Request Failed"
  case jsonConversionFailure = "JSON Conversion Failure"
  case invalidData = "Invalid Data"
  case responseUnsuccessful = "Response Unsuccessful"
  case jsonParsingFailure = "JSON Parsing Failure"
  case connectionLost = "Lost Network Connection"
  case notConnectToInternet = "No Network Connection"
}
