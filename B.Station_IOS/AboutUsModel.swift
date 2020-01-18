//
//  File.swift
//
//  Created by Hassan Ramadan on 9/21/19.
//  Copyright © 2019 Hassan Ramadan IOS/Android Developer Tamkeen CO. All rights reserved.
//



import Foundation
import ObjectMapper


class AboutUS: Codable {
    let code: Int?
    let message: String?
    let data: AboutUSDataClass
    
    init(code: Int, message: String, data: AboutUSDataClass) {
        self.code = code
        self.message = message
        self.data = data
    }
}

class AboutUSDataClass: Codable {
    let id: Int?
    let title, content: String?
    let image, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int?, title: String?, content: String?, image: String?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.title = title
        self.content = content
        self.image = image
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}



class SocialLinks: Codable {
    let code: Int?
    let message: String?
    let data: [SocialLinksDatum]
    
    init(code: Int, message: String, data: [SocialLinksDatum]) {
        self.code = code
        self.message = message
        self.data = data
    }
}

class SocialLinksDatum: Codable {
    let id: Int?
    let type: String?
    let link: String?
    let icon: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, type, link, icon
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int, type: String, link: String, icon: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.type = type
        self.link = link
        self.icon = icon
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}





