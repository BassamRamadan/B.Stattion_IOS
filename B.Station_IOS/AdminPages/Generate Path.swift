//
//  Generate Path.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 12/7/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit
import DropDown
import Spring
import Alamofire
class GeneratePath: common {
    
    let CityDrop = DropDown()
    let RouteDrop = DropDown()
    let StartPointDrop = DropDown()
    let EndPointDrop = DropDown()
    
    var CitiesObjects = [Details]()
    var RoutesObjects = [Details]()
    var StartPointObjects = [Details]()
    var EndPointObjects = [Details]()
    
    var CityId : Int! = nil
    var RouteId : Int! = nil
    var StartPointId : Int! = nil
    var EndPointId : Int! = nil
    
    var StartPointText : String! = "......"
    var EndPointText  : String! = "......"
    
    @IBOutlet weak var CityButton: DesignableButton!
    @IBOutlet weak var RouteButton: DesignableButton!
    @IBOutlet weak var StartPointButton: DesignableButton!
    @IBOutlet weak var EndPointButton: DesignableButton!
    
    @IBOutlet weak var Model: DesignableTextField!
    @IBOutlet weak var carType: DesignableTextField!
    @IBOutlet weak var Phone: DesignableTextField!
    
    @IBOutlet weak var wifiButton: UIButton!
    @IBOutlet weak var shadingButton: UIButton!
    @IBOutlet weak var airButton: UIButton!
    var wifi : Bool! = false
    var shading : Bool! = false
    var airConditioning : Bool! = false
    @IBAction func checkedAndUnchecked(_ sender: Any) {
        if   (sender as! UIButton).currentImage == UIImage(named: "ic_unchecked"){
            (sender as! UIButton).setImage(UIImage(named: "ic_checked"), for: .normal)
        }else{
             (sender as! UIButton).setImage(UIImage(named: "ic_unchecked"), for: .normal)
        }
        switch (sender as! UIButton) {
        case wifiButton:
            wifi = !wifi
        case shadingButton:
            shading = !shading
        case airButton:
            airConditioning = !airConditioning
        default:
            break
        }
    }
    @IBAction func Submit(_ sender: Any) {
        Uploading()
    }
    @IBAction func CityClick(_ sender: DesignableButton) {
        // reset start and end point
        ResetPoints()
        
        CityDrop.anchorView = (sender as AnchorView)
        CityDrop.dataSource = parsingData(self.CitiesObjects)
        CityDrop.bottomOffset = CGPoint(x: 0, y:(CityDrop.anchorView?.plainView.bounds.height)!)
        CityDrop.selectionAction = {
            [unowned self](index : Int , item : String)in
            
            self.CityButton.setTitle(item, for: .normal)
            self.CityId = self.CitiesObjects[index].id
            // startPoint
            self.StartPointObjects.removeAll()
            GetDataForPaths.loadOnLinePoints(self.CityId,-1){ (success : [Details]) in
                self.StartPointObjects.append(contentsOf: success)
            }
            // endPoint
            if self.RouteId != nil{
                self.EndPointObjects.removeAll()
                GetDataForPaths.loadOnLinePoints(self.CityId, self.RouteId){ (success : [Details]) in
                    self.EndPointObjects.append(contentsOf: success)
                }
            }
        }
        CityDrop.show()
    }
    @IBAction func RouteClick(_ sender: DesignableButton) {
        RouteDrop.anchorView = (sender as AnchorView)
        RouteDrop.dataSource = parsingData(self.RoutesObjects)
        RouteDrop.bottomOffset = CGPoint(x: 0, y:(RouteDrop.anchorView?.plainView.bounds.height)!)
        RouteDrop.selectionAction = {
            [unowned self](index : Int , item : String)in
            self.RouteButton.setTitle(item, for: .normal)
            
            self.RouteId = self.RoutesObjects[index].id
            if self.CityId != nil{
                GetDataForPaths.loadOnLinePoints(self.CityId, self.RouteId){ (success : [Details]) in
                    self.EndPointObjects.removeAll()
                    self.EndPointObjects.append(contentsOf: success)
                }
            }
        }
        RouteDrop.show()
    }
    @IBAction func StartPointClick(_ sender: DesignableButton) {
        StartPointDrop.anchorView = (sender as AnchorView)
        StartPointDrop.dataSource = parsingData(self.StartPointObjects)
        StartPointDrop.bottomOffset = CGPoint(x: 0, y:(StartPointDrop.anchorView?.plainView.bounds.height)!)
        
        StartPointDrop.selectionAction = {
            [unowned self](index : Int , item : String)in
            self.StartPointButton.setTitle(item, for: .normal)
            self.StartPointId = self.StartPointObjects[index].id
            self.StartPointText = self.StartPointObjects[index].name
        }
        StartPointDrop.show()
    }
    @IBAction func EndPointClick(_ sender: DesignableButton) {
        EndPointDrop.anchorView = (sender as AnchorView)
        EndPointDrop.dataSource = parsingData(self.EndPointObjects)
        EndPointDrop.bottomOffset = CGPoint(x: 0, y:(EndPointDrop.anchorView?.plainView.bounds.height)!)
        
        EndPointDrop.selectionAction = {
            [unowned self](index : Int , item : String)in
            self.EndPointButton.setTitle(item, for: .normal)
            self.EndPointId = self.EndPointObjects[index].id
            self.EndPointText = self.EndPointObjects[index].name
        }
        EndPointDrop.show()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        GetDataForPaths.loadOnLineCities { (success : [Details]) in
            self.CitiesObjects = success
        }
        GetDataForPaths.loadOnLineRoute { (success : [Details]) in
            self.RoutesObjects = success
        }
    }
    fileprivate func parsingData(_ data : [Details])->[String]{
        var ResData = [String]()
        for x in data {
            ResData.append(x.name ?? "")
        }
        return ResData
    }
    fileprivate func ResetPoints(){
        StartPointDrop.dataSource.removeAll()
        EndPointDrop.dataSource.removeAll()
        StartPointButton.setTitle("", for: .normal)
        EndPointButton.setTitle("", for: .normal)
        StartPointId = nil
        EndPointId = nil
        StartPointText = "......"
        EndPointText = "......"
    }
    fileprivate func Uploading(){
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/company/add-traffic"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json",
                        "Authorization" : "Bearer \(CashedData.getAdminUpdateKey() ?? "")"
        ]
        let params = ["city_id":self.CityId as Any,
                      "traffic_id":self.RouteId as Any,
                      "from_station_id":self.StartPointId as Any,
                      "to_station_id":self.EndPointId as Any,
                      "phone":Phone.text as Any,
                      "vichel_type":carType.text as Any,
                      "vichel_model":Model.text as Any,
                      "air_conditioning":airConditioning as Any,
                      "shading":shading as Any,
                      "wifi":wifi as Any
                      
        ]
        AlamofireRequests.PostMethod(methodType: "POST", url: url, info: params, headers: headers){
            (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        self.present(common.makeAlert(message: "تم إضافةالمسار بنجاح"), animated: true, completion: nil)
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    }
                }else{
                        self.present(common.makeAlert(), animated: true, completion: nil)
                }
            }catch {
                        self.present(common.makeAlert(message: error.localizedDescription), animated: true, completion: nil)
            }
        }
    }
}
