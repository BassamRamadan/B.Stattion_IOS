//
//  UserProfile.swift
//  Tourist-Guide
//
//  Created by mac on 12/4/19.
//  Copyright © 2019 Tamkeen. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    let code: Int
    let message: String
    let data: User?
    
    init(code: Int, message: String, data: User?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

struct User: Codable {
    
    let id: Int
    let name, email, username: String
    let firebase,imagePath: String?
    let code, balanceRewards, balanceInvitations, balance: String?
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, username, firebase, code, balance
        case imagePath = "image_path"
        case balanceRewards = "balance_rewards"
        case balanceInvitations = "balance_invitations"
        case accessToken = "access_token"
        
    }
    
    init(id: Int, name: String, email: String, username: String, firebase: String?, imagePath: String?, code: String?, balanceRewards: String?, balanceInvitations: String?, balance: String?,accessToken: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.username = username
        self.firebase = firebase
        self.imagePath = imagePath
        self.code = code
        self.balanceRewards = balanceRewards
        self.balanceInvitations = balanceInvitations
        self.balance = balance
        self.accessToken = accessToken
    }
}
