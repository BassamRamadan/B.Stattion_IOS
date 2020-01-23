//
//  trafficRoutes.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/18/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
class Companies: Codable{
    let code: Int?
    let message: String?
    let data: [RoutesDetails]
    
    init(code: Int, message: String, data: [RoutesDetails]) {
        self.code = code
        self.message = message
        self.data = data
    }
}
class Paths: Codable{
    let code: Int?
    let message: String?
    let data: RoutesDetails
    
    init(code: Int, message: String, data: RoutesDetails) {
        self.code = code
        self.message = message
        self.data = data
    }
}
class RoutesDetails: Codable{
    let avgRate: Double?
    let id: Int?
    let name,cityId,phone,whatsapp,email,image,code,ordering,lat,lon,status,bio,username,cityName: String?
    let imagePath: String?
    let trafficRoutes: [trafficRoutes]
    let images:[imageDetails]
    let userRates : [userRates]
    enum CodingKeys: String,CodingKey{
        case id,name,phone,whatsapp,email,image,code,ordering,lat,lon,status,bio,username,images
        case trafficRoutes = "traffic_routes"
        case imagePath = "image_path"
        case cityId = "city_id"
        case avgRate = "avg_rate"
        case cityName = "city_name"
        case userRates = "user_rates"
    }
    init(id: Int,avgRate: Double, trafficRoutes: [trafficRoutes],images:[imageDetails],userRates : [userRates],name: String,
         cityId: String,phone: String,whatsapp: String,email: String,image: String,code: String,ordering: String,lat: String,lon: String,status: String,bio: String,username: String,cityName: String,imagePath:String) {
        self.id = id
        self.avgRate = avgRate
        self.trafficRoutes = trafficRoutes
        self.images = images
        self.userRates = userRates
        self.name = name
        self.cityId = cityId
        self.phone = phone
        self.whatsapp = whatsapp
        self.email = email
        self.image = image
        self.code = code
        self.ordering = ordering
        self.lat = lat
        self.lon = lon
        self.status = status
        self.bio = bio
        self.username = username
        self.cityName = cityName
        self.imagePath = imagePath
    }
    
}
class trafficRoutes: Codable{
    let id: Int?
    let phone , carType , carModel, fromStation,toStation: String
    let airConditioning, wifi, shading:Bool
    enum CodingKeys: String, CodingKey {
        case id, phone, wifi, shading
        case carType = "vichel_type"
        case carModel = "vichel_model"
        case airConditioning = "air_conditioning"
        case fromStation = "from_station_name"
        case toStation = "to_station_name"
    }
    init(id: Int, phone: String, carType: String, carModel: String,fromStation: String, toStation: String,
         shading:Bool, wifi: Bool ,airConditioning: Bool ) {
        self.id = id
        self.airConditioning = airConditioning
        self.carModel = carModel
        self.phone = phone
        self.shading = shading
        self.wifi = wifi
        self.carType = carType
        self.fromStation = fromStation
        self.toStation = toStation
    }
}
class imageDetails: Codable{
    let id: Int
    let companyId,imagePath:String
    enum CodingKeys: String,CodingKey{
        case id
        case companyId = "company_id"
        case imagePath = "image_path"
    }
    init(id:Int , companyId:String ,imagePath:String) {
        self.companyId = companyId
        self.imagePath = imagePath
        self.id = id
    }
}
class userRates: Codable {
    let userId ,companyId,rate,comment,createdAt,userName,userImage: String?
    enum CodingKeys: String,CodingKey{
        case rate,comment
        case userId = "user_id"
        case companyId = "company_id"
        case createdAt = "created_at"
        case userName = "user_name"
        case userImage = "user_image"
    }
    init(userId:String , companyId:String ,rate:String, comment:String ,createdAt:String
       , userName:String ,userImage:String ) {
        self.comment = comment
        self.companyId = companyId
        self.createdAt = createdAt
        self.rate = rate
        self.userId = userId
        self.userImage = userImage
        self.userName = userName
    }
}

