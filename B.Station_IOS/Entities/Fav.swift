//
//  Fav.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/19/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

class FavList: Codable{
    let code: Int?
    let message: String?
    let data: [FavDetails]
    init(code: Int , message: String , data: [FavDetails]) {
        self.code = code
        self.message = message
        self.data = data
    }
}

class FavDetails: Codable{
    let id , AvgRate: Int
    let CompanyId, name,ImagePath , CityName: String?
    enum CodingKeys: String , CodingKey{
        case id , name
        case AvgRate = "avg_rate",ImagePath = "image_path"
        case CompanyId = "company_id",CityName = "city_name"
    }
    init(id:Int,AvgRate:Int,CompanyId: String, name: String,ImagePath: String? , CityName: String) {
        self.id = id
        self.AvgRate = AvgRate
        self.CityName = CityName
        self.CompanyId = CompanyId
        self.name = name
        self.ImagePath = ImagePath
    }
}
class FavoritesID: Codable{
    let code: Int?
    let message: String?
    let data: [FavID]
    init(code: Int , message: String , data: [FavID]) {
        self.code = code
        self.message = message
        self.data = data
    }
}
class FavID : Codable{
    let CompanyId: String
    enum CodingKeys: String , CodingKey{
        case CompanyId = "company_id"
    }
    init(CompanyId: String) {
        self.CompanyId = CompanyId
    }
}
