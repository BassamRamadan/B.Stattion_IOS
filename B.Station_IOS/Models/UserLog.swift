//
//  UserProfile.swift
//  Tourist-Guide
//
//  Created by mac on 12/4/19.
//  Copyright © 2019 Tamkeen. All rights reserved.
//

import Foundation

struct UserLog: Codable {
    let code: Int
    let message: String
    let data: LogDetails?
    
    init(code: Int, message: String, data: LogDetails?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

struct LogDetails: Codable {
    
    let id: Int
    let name, phone: String
    let imagePath ,firebase,status,password: String?
    let code: String?
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, phone, code,firebase,status,password
        case imagePath = "image_path"
        case accessToken = "access_token"
    }
    
    init(id: Int, name: String, phone: String, imagePath: String?, code: String?,accessToken: String?,firebase: String?,status: String?,password: String?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.imagePath = imagePath
        self.code = code
        self.accessToken = accessToken
        self.password = password
        self.firebase = firebase
        self.status = status
    }
}
