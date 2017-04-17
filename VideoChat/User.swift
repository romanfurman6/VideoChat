//
//  User.swift
//  VideoChat
//
//  Created by Roman Furman on 4/16/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import Foundation

class User {
    let name: String
    let password: String
    let id: NSNumber
    var inUsed: Bool = false

    init(name: String, password: String, id: NSNumber) {
        self.name = name
        self.password = password
        self.id = id
    }
}
