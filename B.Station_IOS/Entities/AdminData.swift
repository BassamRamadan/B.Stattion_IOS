//
//  UserProfile.swift
//  Tourist-Guide
//
//  Created by mac on 12/4/19.
//  Copyright © 2019 Tamkeen. All rights reserved.
//

import Foundation

struct AdminLogin: Codable {
    let code: Int
    let message: String
    let data: AdminLoginDetails?
    
    init(code: Int, message: String, data: AdminLoginDetails?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

struct AdminLoginDetails: Codable {
    
    let id: Int
    let name, phone,status,username: String
    let accessToken,imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, phone,status,username
        case imagePath = "image_path"
        case accessToken = "access_token"
    }
    
    init(id: Int, name: String, phone: String, imagePath: String?, status: String,accessToken: String?,username : String) {
        self.id = id
        self.name = name
        self.phone = phone
        self.imagePath = imagePath
        self.status = status
        self.accessToken = accessToken
        self.username = username
       // self.password = password
    }
}
