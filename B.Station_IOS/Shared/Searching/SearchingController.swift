//
//  SearchingController.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/18/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import Spring
import DropDown

class SearchingController: common {
    
    var AllCompanies = [RoutesDetails]()
    
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
    
    
    @IBAction func Submit(_ sender: Any) {
            self.loadingCompanies()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchingDetails"{
            if let distination = segue.destination as? TransportCompanies {
                distination.search = true
                distination.name = self.StartPointText
                distination.path = self.EndPointText
                distination.AllCompanies.removeAll()
                distination.AllCompanies.append(contentsOf: self.AllCompanies)
            }
        }
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
                GetDataForPaths().loadOnLinePoints(self.CityId,-1){ (success : [Details]) in
                   self.StartPointObjects.append(contentsOf: success)
                }
                // endPoint
                if self.RouteId != nil{
                    self.EndPointObjects.removeAll()
                    GetDataForPaths().loadOnLinePoints(self.CityId, self.RouteId){ (success : [Details]) in
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
                GetDataForPaths().loadOnLinePoints(self.CityId, self.RouteId){ (success : [Details]) in
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

        GetDataForPaths().loadOnLineCities { (success : [Details]) in
            self.CitiesObjects.removeAll()
            self.CitiesObjects.append(contentsOf: success)
        }
        GetDataForPaths().loadOnLineRoute { (success : [Details]) in
            self.RoutesObjects.removeAll()
            self.RoutesObjects.append(contentsOf: success)
        }
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
    fileprivate func parsingData(_ data : [Details])->[String]{
        var ResData = [String]()
        for x in data {
            ResData.append(x.name ?? "")
        }
        return ResData
    }
    
    fileprivate func loadingCompanies(){
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/companies"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        var params = ["city_id":"","traffic_id":"","start_point":"","end_point":""]
        if self.CityId != nil{
            params.updateValue(String(self.CityId), forKey: "city_id")
        }
        if self.RouteId != nil{
            params.updateValue(String(self.RouteId), forKey: "traffic_id")
        }
        if self.StartPointId != nil{
            params.updateValue(String(self.StartPointId), forKey: "start_point")
        }
        if self.EndPointId != nil{
            params.updateValue(String(self.EndPointId), forKey: "end_point")
        }
         self.AllCompanies.removeAll()
        AlamofireRequests.PostMethod(methodType: "Get", url: url, info: params as [String : Any], headers: headers)
        { (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        let propertiesRecived = try decoder.decode(Companies.self, from: jsonData)
                        self.AllCompanies.append(contentsOf: propertiesRecived.data)
                        if self.AllCompanies.count == 0{
                            self.present(common.makeAlert(message: "لا يوجد بيانات مطابقة"), animated: true, completion: nil)
                        }else{
                            self.performSegue(withIdentifier: "SearchingDetails", sender: self)
                        }
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    }
                }else{
                    self.present(common.makeAlert(), animated: true, completion: nil)
                    
                }
            } catch {
                self.present(common.makeAlert(message: error.localizedDescription), animated: true, completion: nil)
                
            }
        }
    }
}
