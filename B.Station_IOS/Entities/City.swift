//
//  City.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/17/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation
class City: Codable {
    let code: Int?
    let message: String?
    let data: [Details]
    
    init(code: Int, message: String, data: [Details]) {
        self.code = code
        self.message = message
        self.data = data
    }
}

class Details: Codable {
    let id: Int?
    let name: String?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
