//
//  Network.swift
//
//  Created by Hassan Ramadan on 9/21/19.
//  Copyright © 2019 Hassan Ramadan IOS/Android Developer Tamkeen CO. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import AlamofireImage





class AlamofireRequests {
    
   class func getMethod (url : String , headers: [String :String ] , complition :  @escaping (_ error:Error? ,_ success: Bool ,_ data:Data)->Void){
        
        let url = url
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result
            {
            case .failure(let error):
                print(error)
            case .success(let value):
                print (value)
                complition(nil, true, value)
            }
        }
    }
    
    class func PostMethod (methodType: String, url : String , info: [String :Any ] , headers: [String :String ], complition :   @escaping (_ error:Error? ,_ success: Bool , _ data:Data) -> Void){
        
        
        let url = url
        let parameters = info
        let urlComponent = URLComponents(string: url)!
        let headers = headers
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = methodType
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.allHTTPHeaderFields = headers
        
        
        Alamofire.request(request).responseData { (response) in
            
            switch response.result {
            case .success(let value ):
                print("JSON: \(value)")
                complition(nil, true , value)
            case .failure (let error):
                print(error)
              
                
            }
        }
        
    }
    
    class func saloonSignUp (url : String , info: [String :Any ],images:[UIImage],saloonImage: UIImage?,reciptImage: UIImage?, headers: [String :String ], complition :   @escaping (_ error:Error? ,_ success: Bool , _ data:Data) -> Void){
        
        
        let url = url
        let params: Parameters = info
        //  self.post(url, params: params, handler: handler)
        
        ///////////////////////////////////////////
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            var i = 0
            for img in images {
                let imgData = img.jpegData(compressionQuality: 0.1)!
                multipartFormData.append(imgData, withName: "images[]",fileName: "images\(i+=1).png", mimeType: "image/jpg")
            }
            if saloonImage != nil{
            let imgData = saloonImage!.jpegData(compressionQuality: 0.1)!
            multipartFormData.append(imgData, withName: "image",fileName: "image.png", mimeType: "image/jpg")
            }
            if reciptImage != nil{
                let imgData = reciptImage!.jpegData(compressionQuality: 0.1)!
                multipartFormData.append(imgData, withName: "reciept_image",fileName: "reciept_image.png", mimeType: "image/jpg")
            }
            for (key, value) in params {
                multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
            }
            
        }, usingThreshold:UInt64.init(), to:url , method:.post, headers: headers){
            (result) in
            switch result {
            case .success(let upload, _ , _):
                
                upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Int(Progress.fractionCompleted*1000))")
                })
                
                upload.responseData { (response) in
                    switch response.result {
                    case .success(let value ):
                        print("JSON: \(value)")
                        if let status = response.response?.statusCode {
                            if status >= 200 && status < 300{
                                complition(nil, true , value)
                            }else{
                                complition(nil, false , value)
                            }
                        }
                    case .failure (let error):
                        complition(error, false , Data())
                        print(error)
                    }
                }
            case .failure(let error):
                complition(error, false , Data())
                print(error)
                break
            }
        }
    }
    
    class func uploadMethod (url : String , info: [String :Any ],images:[UIImage],imageName: String, headers: [String :String ], complition :   @escaping (_ error:Error? ,_ success: Bool , _ data:Data) -> Void){
        
        
        let url = url
        let params: Parameters = info
        //  self.post(url, params: params, handler: handler)
        
        ///////////////////////////////////////////
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for img in images {
                let imgData = img.jpegData(compressionQuality: 0.1)!
                multipartFormData.append(imgData, withName: imageName,fileName: imageName+".png", mimeType: "image/jpg")
            }
            for (key, value) in params {
                multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
            }
            
        }, usingThreshold:UInt64.init(), to:url , method:.post, headers: headers){
            (result) in
            switch result {
            case .success(let upload, _ , _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseData { (response) in
                    
                    switch response.result {
                    case .success(let value ):
                        print("JSON: \(value)")
                        complition(nil, true , value)
                    case .failure (let error):
                        print(error)
                        
                        
                    }
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
//    class func uploadMethod (url : String , info: [String :Any ],image:[UIImage] , headers: [String :String ], complition :   @escaping (_ error:Error? ,_ success: Bool , _ data:Data) -> Void){
//        
//        
//        let url = url
//        let parameters = info
//        let urlComponent = URLComponents(string: url)!
//        let headers = headers
//        var request = URLRequest(url: urlComponent.url!)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//        request.allHTTPHeaderFields = headers
//        
//      
//        
//        
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//                
//                for (key,value) in parameters {
//                    if let value = value as? String {
//                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                    }
//                }
//                var i = 0
//                for (img) in image {
//                    if  let imageData = img.jpegData(compressionQuality: 0.01) {
//                        multipartFormData.append(imageData, withName: "image[\(i)]", fileName: "image.jpeg", mimeType: "image/jpeg")
//                        i += 1
//                    }
//                }
//        },
//            to: url,
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseData { response in
//                        switch response.result {
//                        case .success(let value ):
//                            print("JSON: \(value)")
//                            complition(nil, true , value)
//                        case .failure (let error):
//                            print(error)
//                            
//                            
//                        }
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//        })
//    }
    
   
    
   class func getPhoto (url: String , complition :   @escaping (_ error:Error? ,_ success: Bool , _ photo: UIImage ) -> Void){
        let  imageUrl =  url
        Alamofire.request(imageUrl, method: .get).responseImage { response in
            guard let image = response.result.value else {
                // Handle error
                return
            }
            // Do stuff with your image
            complition(nil,true , image)
        }
    }
        
}
