//
//  ClassesGetData.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/18/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import Alamofire
class GetDataForPaths : common{
    class func loadOnLineCities(_ parent:common?,completion : @escaping (_ success:[Details]) -> Void ){
        let url = "https://services-apps.net/bstation/public/api/cities"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        AlamofireRequests.getMethod(url: url, headers: headers) { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        let propertiesRecived = try decoder.decode(City.self, from: jsonData)
                        completion(propertiesRecived.data)
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        parent?.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    }
                }else{
                        parent?.present(common.makeAlert(), animated: true, completion: nil)
                }
            } catch {
                    parent?.present(common.makeAlert(message: error.localizedDescription), animated: true, completion: nil)
            }
        }
    }
    class func loadOnLineRoute(_ parent:common?,completion : @escaping (_ success:[Details]) -> Void ){
       let url = "https://services-apps.net/bstation/public/api/main-traffic"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        AlamofireRequests.getMethod(url: url, headers: headers) { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        let propertiesRecived = try decoder.decode(City.self, from: jsonData)
                        completion(propertiesRecived.data)
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        parent?.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    }
                }else{
                    parent?.present(common.makeAlert(), animated: true, completion: nil)
                }
            } catch {
                parent?.present(common.makeAlert(message: error.localizedDescription), animated: true, completion: nil)
            }
        }
    }
    class func loadOnLinePoints(_ parent:common?,_ cityId:Int ,_ RouteId : Int,completion : @escaping (_ success:[Details]) -> Void ){
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
                if error == nil{
                    if success{
                        let propertiesRecived = try decoder.decode(City.self, from: jsonData)
                        completion(propertiesRecived.data)
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        parent?.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    }
                }else{
                    parent?.present(common.makeAlert(), animated: true, completion: nil)
                }
            } catch {
                parent?.present(common.makeAlert(message: error.localizedDescription), animated: true, completion: nil)
            }
        }
    }
}
