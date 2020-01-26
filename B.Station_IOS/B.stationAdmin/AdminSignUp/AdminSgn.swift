//
//  AdminSgn.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/25/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import Spring
import MapKit
import DropDown
class AdminSgn: common {
    var CitiesObjects = [Details]()
    let CityDrop = DropDown()
    var cityID : Int!
    var counter = 1
    @IBOutlet weak var name: DesignableTextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var whatsapp: UITextField!
    @IBOutlet weak var email: DesignableTextField!
    @IBOutlet weak var bio: DesignableTextView!
    @IBOutlet weak var PhotosCollection: UICollectionView!
    @IBAction func CityButton(_ sender: DesignableButton) {
        CityDrop.anchorView = (sender as AnchorView)
        CityDrop.dataSource = parsingData(self.CitiesObjects)
        CityDrop.bottomOffset = CGPoint(x: 0, y:(CityDrop.anchorView?.plainView.bounds.height)!)
        CityDrop.selectionAction = { [unowned self](index : Int , item : String)in
           sender.setTitle(item, for: .normal)
           self.cityID = self.CitiesObjects[index].id
        }
        CityDrop.show()
    }
    @IBAction func AddImage(_ sender: UIButton) {
        
    }
    @IBOutlet weak var map: MKMapView!
  
    @IBOutlet weak var username: DesignableTextField!
    
    @IBOutlet weak var password: DesignableTextField!
    
    @IBOutlet weak var passwordConfimation: DesignableTextField!
    
    @IBAction func Next(_ sender: Any) {
        ViewInfomation.isHidden = true
        ViewLocation.isHidden = false
        counter = 2
        setupBackButton()
        self.navigationItem.title = "موقع الشركة"
    }
    @IBAction func Submit(_ sender: DesignableButton) {
        login()
    }
    
    
    @IBOutlet weak var ViewInfomation: UIView!
    @IBOutlet weak var ViewLocation: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
         ViewLocation.isHidden = true
         setupBackButton()
        self.navigationItem.title = "معلومات الشركة"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        GetDataForPaths.loadOnLineCities { (success : [Details]) in
            self.CitiesObjects.removeAll()
            self.CitiesObjects.append(contentsOf: success)
            print(self.CitiesObjects.count)
        }
    }
    private func setupBackButton(){
        self.navigationItem.hidesBackButton = true
        let backBtn: UIButton = common.drowbackButton()
        let backButton = UIBarButtonItem(customView: backBtn)
        self.navigationItem.setRightBarButton(backButton, animated: true)
        backBtn.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
    }
    @objc func back(){
        print("accessed")
        if counter == 1{
           self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationItem.title = "معلومات الشركة"
            ViewInfomation.isHidden = false
            ViewLocation.isHidden = true
            counter = 1
        }
    }
    fileprivate func parsingData(_ data : [Details])->[String]{
        var ResData = [String]()
        for x in data {
            ResData.append(x.name ?? "")
        }
        return ResData
    }
    fileprivate func login() {
        self.loading()
        let url : String = "https://services-apps.net/bstation/public/api/company-signup"
        let info : [String : Any]
            info = [
            "name":self.name.text! ,
            "username": self.username.text ?? "",
            "password": self.password.text ?? "",
            "phone": self.phone.text ?? "",
            "whatsapp": self.whatsapp.text ?? "",
            "email": self.email.text ?? "",
            "bio": self.bio.text ?? "",
            "password_confirmation": self.passwordConfimation.text ?? "",
            "city_id": String(self.cityID ?? 0),
            "lat": String(29.23423234),
            "lon": String(37.23423234),
        ]
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        AlamofireRequests.PostMethod( methodType: "POST", url: url, info: info, headers: headers) { (error, success , jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        let dataRecived = try decoder.decode(AdminLogin.self, from: jsonData)
                        if dataRecived.code >= 201 && dataRecived.code < 300{
                            if let Admin = dataRecived.data{
                                CashedData.saveAdminApiKey(token: (Admin.accessToken ?? ""))
                                CashedData.saveAdminUpdateKey(token: (Admin.accessToken ?? ""))
                                CashedData.saveAdminData(admin: Admin)
                                CashedData.saveAdminPhone(name: Admin.phone )
                                CashedData.saveAdminID(name: Admin.id )
                                CashedData.saveAdminUserName(name: Admin.username)
                                CashedData.saveAdminName(name: Admin.name)
                            }
                        }
                        let storyboard = UIStoryboard(name: "AdminLog", bundle: nil)
                        let linkingVC = storyboard.instantiateViewController(withIdentifier: "AdminLog")
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = linkingVC
                        
                    }
                    else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    }
                }
                else{
                    let message = NSLocalizedString("عفوا حدث خطأ اثناء التسجيل بسبب الانترنت برجاء المحاوله مره اخري", comment: "error login")
                    
                    self.present(common.makeAlert(message: message), animated: true, completion: nil)
                }
                
            } catch {
                self.present(common.makeAlert(message: error.localizedDescription), animated: true, completion: nil)
            }
        }
    }

}
