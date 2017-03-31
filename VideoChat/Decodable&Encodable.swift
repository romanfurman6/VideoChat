//
//  Decodable&Encodable.swift
//  VideoChat
//
//  Created by Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import Foundation

protocol Decodable {
  init?(from dictionary: [String: Any])
}

protocol Encodable {
  var jsonValue: [String: Any] { get }
}
