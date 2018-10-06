//
//  Response.swift
//  NASApp
//
//  Created by Michele Mola on 06/10/2018.
//  Copyright © 2018 Michele Mola. All rights reserved.
//

import Foundation

enum Response<T, U> where U: Error {
  case success(T)
  case failure(U)
}
