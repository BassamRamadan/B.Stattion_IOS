//
//  ClassesGetData.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/18/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import Alamofire
class GetDataForPaths : NSObject{
     class func loadOnLineCities(completion : @escaping (_ success:[Details]) -> Void ){
        let url = "https://services-apps.net/bstation/public/api/cities"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        AlamofireRequests.getMethod(url: url, headers: headers) { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                let propertiesRecived = try decoder.decode(City.self, from: jsonData)
                completion(propertiesRecived.data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    class func loadOnLineRoute(completion : @escaping (_ success:[Details]) -> Void ){
       let url = "https://services-apps.net/bstation/public/api/main-traffic"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        AlamofireRequests.getMethod(url: url, headers: headers) { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                let propertiesRecived = try decoder.decode(City.self, from: jsonData)
                completion(propertiesRecived.data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    class func loadOnLinePoints(_ cityId:Int ,_ RouteId : Int,completion : @escaping (_ success:[Details]) -> Void ){
        let url = "https://services-apps.net/bstation/public/api/traffic-stations"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        var params = [String : Any]()
        if RouteId == -1{
            params = ["city_id":cityId,
                      "start_point":1
            ]
        }else{
             params = ["city_id":cityId,
                          "traffic_id":RouteId,
                          "start_point":0
            ]
        }
        AlamofireRequests.getMethod(url: url,params , headers: headers)
        { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                let propertiesRecived = try decoder.decode(City.self, from: jsonData)
                completion(propertiesRecived.data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
