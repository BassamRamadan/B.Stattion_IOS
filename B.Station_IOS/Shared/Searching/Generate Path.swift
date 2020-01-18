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
class GeneratePath: UIViewController {
    
    var CitiesObjects = [Details]()
    var RoutesObjects = [Details]()
    var StartPointObjects = [Details]()
    var EndPointObjects = [Details]()
    
    var CityId : Int! = nil
    var RouteId : Int! = nil
    var StartPointId : Int! = nil
    var EndPointId : Int! = nil
    
    @IBOutlet weak var CityButton: DesignableButton!
    @IBOutlet weak var PathButton: DesignableButton!
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
        
    }
    @IBAction func Cityclick(_ sender: DesignableButton) {
        let dd = DropDown()
        dd.anchorView = (sender as AnchorView)
        switch sender {
        case CityButton:
            dd.dataSource = parsingData(self.CitiesObjects)
        case PathButton:
            dd.dataSource = parsingData(self.RoutesObjects)
        case EndPointButton:
            dd.dataSource = parsingData(self.EndPointObjects)
        case StartPointButton:
            dd.dataSource = parsingData(self.StartPointObjects)
        default:
            break
        }
        dd.bottomOffset = CGPoint(x: 0, y:(dd.anchorView?.plainView.bounds.height)!)
        dd.selectionAction = {[unowned self](index : Int , item : String)in
            (sender as DesignableButton).setTitle(item, for: .normal)
            switch sender {
            case self.CityButton:
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
                
            case self.PathButton:
                self.RouteId = self.RoutesObjects[index].id
                if self.CityId != nil{
                    GetDataForPaths().loadOnLinePoints(self.CityId, self.RouteId){ (success : [Details]) in
                        self.EndPointObjects.removeAll()
                        self.EndPointObjects.append(contentsOf: success)
                    }
                }
            case self.EndPointButton:
                self.EndPointId = self.EndPointObjects[index].id
            case self.StartPointButton:
                self.StartPointId = self.StartPointObjects[index].id
            default:
                break
            }
        }
        dd.show()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let xx = SearchingController()
        GetDataForPaths().loadOnLineCities { (success : [Details]) in
            self.CitiesObjects = success
        }
        GetDataForPaths().loadOnLineRoute { (success : [Details]) in
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
   
   
}
