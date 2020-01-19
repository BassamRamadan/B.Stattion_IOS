//
//  Category.swift
//
//  Created by Hassan Ramadan on 9/21/19.
//  Copyright © 2019 Hassan Ramadan IOS/Android Developer Tamkeen CO. All rights reserved.
//



import Foundation

class ItemDataClass: Codable {
    let code: Int
    let message: String
    let data: [Item]?
    
    init(code: Int, message: String, data: [Item]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

class Item: Codable {
    let id: Int
    let name: String
    let translation: [Item]?
    
    
    enum CodingKeys: String, CodingKey {
        case id, name,translation
        
    }
    
    init(id: Int, name: String, translation: [Item]?) {
        self.id = id
        self.name = name
        self.translation = translation
    }
}
