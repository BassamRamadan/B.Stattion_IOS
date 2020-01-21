//
//  UserProfile.swift
//  Tourist-Guide
//
//  Created by mac on 12/4/19.
//  Copyright © 2019 Tamkeen. All rights reserved.
//

import Foundation

struct UserSign: Codable {
    let code: Int
    let message: String
    let data: SignDetails?
    
    init(code: Int, message: String, data: SignDetails?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

struct SignDetails: Codable {
    
    let id: Int
    let name, phone: String
    let imagePath: String?
    let code: Int?
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, phone, code
        case imagePath = "image_path"
        case accessToken = "access_token"
    }
    
    init(id: Int, name: String, phone: String, imagePath: String?, code: Int?,accessToken: String?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.imagePath = imagePath
        self.code = code
        self.accessToken = accessToken
    }
}
