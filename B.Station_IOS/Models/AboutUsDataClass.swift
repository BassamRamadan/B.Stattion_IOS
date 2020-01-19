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
    
    enum CodingKeys: String, CodingKey {
        case id, title, content
        
    }
    
    init(id: Int?, title: String?, content: String? ) {
        self.id = id
        self.title = title
        self.content = content
    
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
    let iconPath: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, type, link
        case iconPath = "icon_path"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(id: Int, type: String, link: String, iconPath: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.type = type
        self.link = link
        self.iconPath = iconPath
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

class AppContacts: Codable {
    let code: Int?
    let message: String?
    let data: Contacts
    
    init(code: Int, message: String, data: Contacts) {
        self.code = code
        self.message = message
        self.data = data
    }
}


class Contacts: Codable {
    let phone, whatsapp, telegram: String?
    
    enum CodingKeys: String, CodingKey {
        case phone, whatsapp, telegram
        
    }
    
    init(phone: String?, whatsapp: String?, telegram: String? ) {
        self.phone = phone
        self.whatsapp = whatsapp
        self.telegram = telegram
    
    }
}

