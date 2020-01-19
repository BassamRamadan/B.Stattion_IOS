//
//  Created by Hassan Ramadan on 9/21/19.
//  Copyright © 2019 Hassan Ramadan IOS/Android Developer Tamkeen CO. All rights reserved.
//

import UIKit

struct AllGuides: Codable {
    let code: Int?
    let message: String?
    var data: [GuideData]
    
    init(code: Int, message: String, data: [GuideData]) {
        self.code = code
        self.message = message
        self.data = data
    }
}

struct GuideDetails: Codable {
    let code: Int?
    let message: String?
    var data: GuideData
    
    init(code: Int, message: String, data: GuideData) {
        self.code = code
        self.message = message
        self.data = data
    }
}
struct GuideData: Codable {
    let id , ratesCount , ratesPercentage : Int?
    let name , age, classification , bio: String?
    let dailyPayment,nationality,fullRatesCount,status : String?
    let phone,whatsapp,email: String?
    let code, balanceRewards, balanceInvitations, balance: String?
    let hasLicense ,hasCar,hasRentCars : Bool?
    let GuideImage,guideBackground: String?
    let languages : [language]?
    let country : Countries?
    let cities : [Countries]?
    let cars : [Cars]?
    enum CodingKeys: String, CodingKey {
        case name , age, classification , bio ,id , nationality,status,phone,whatsapp,email,code,
        languages, country,cities,cars,balance
        case dailyPayment = "daily_payment"
        case fullRatesCount = "full_rates_count"
        case ratesPercentage = "rates_percentage"
        case hasRentCars = "has_rent_cars"
        case hasCar = "has_car"
        case balanceRewards = "balance_rewards"
        case balanceInvitations = "balance_invitations"
        case hasLicense = "is_licensed"
        case GuideImage = "image_path"
        case guideBackground = "cover_path"
        case ratesCount = "rates_count"
    }
    init(id: Int, name: String , age : String, classification : String,bio: String,
         dailyPayment: String,nationality: String,fullRatesCount: String,status: String,
         phone: String,whatsapp: String,email: String,code: String,balanceRewards: String,balanceInvitations: String,balance: String,ratesPercentage: Int, GuideImage: String,guideBackground:String,hasLicense: Bool ,hasCar: Bool,hasRentCars: Bool, languages : [language] , ratesCount : Int,cities : [Countries],country:Countries?,cars:[Cars]?) {
        self.id = id
        self.name = name
        self.age = age
        self.classification = classification
        self.bio = bio
        self.dailyPayment = dailyPayment
        self.nationality = nationality
        self.fullRatesCount = fullRatesCount
        self.status = status
        self.ratesPercentage = ratesPercentage
        self.GuideImage = GuideImage
        self.guideBackground = guideBackground
        self.hasLicense = hasLicense
        self.hasCar = hasCar
        self.hasRentCars = hasRentCars
        self.languages = languages
        self.ratesCount = ratesCount
        self.cities = cities
        self.country = country
        self.cars = cars
        self.phone = phone
        self.whatsapp = whatsapp
        self.email = email
        self.balance = balance
        self.code = code
        self.balanceRewards = balanceRewards
        self.balanceInvitations = balanceInvitations
    }
}
struct language : Codable {
    let name: String?
    init(name: String) {
        self.name = name
    }
}

struct Countries : Codable {
    let id: Int?
    let name: String?
    let translations: [Country]?
    init(id: Int, name: String, translations:[Country]?) {
        self.id = id
        self.name = name
        self.translations = translations
    }
}
struct Country : Codable {
    let id: Int?
    let name: String?
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

struct Cars : Codable {
    let id: Int?
    let name: String?
    let modelNumber,passengers,dailyCost,imagPath: String?
    init(id: Int, name: String, modelNumber: String, passengers: String,
         dailyCost: String, imagePath: String?) {
        self.id = id
        self.name = name
        self.modelNumber = modelNumber
        self.passengers = passengers
        self.dailyCost = dailyCost
        self.imagPath = imagePath
    }
    enum CodingKeys: String, CodingKey {
        case id,name , passengers
        case modelNumber = "model_number"
        case dailyCost = "daily_cost"
        case imagPath = "image_path"
    }
}

