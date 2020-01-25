//
//  AdminLog.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/24/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class AdminLog: common {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func rem(_ sender: Any) {
        if  (sender as! UIButton).currentImage == UIImage(named: "ic_unchecked"){
            (sender as! UIButton).setImage(UIImage(named: "ic_checked"), for: .normal)
        }else{
            (sender as! UIButton).setImage(UIImage(named: "ic_unchecked"), for: .normal)
        }
    }
    @IBAction func Log(_ sender: Any) {
        CashedData.saveAdminUserName(name: name.text ?? "")
        CashedData.saveAdminPassword(name: password.text ?? "")
        login("oldAdmin")
    }
    @IBAction func Sign(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(CashedData.getAdminID() as Any)
      
    }
    fileprivate func login(_ userType : String) {
        self.loading()
        var url : String
        var info : [String : Any]
        if userType == "newAdmin"{
            url = "https://services-apps.net/bstation/public/api/company-signup"
            info = ["phone": CashedData.getUserPhone() ?? "",
                    "code": CashedData.getUserCode() as Any
            ]
        }else{
            url = "https://services-apps.net/bstation/public/api/company-login"
            info = ["username": CashedData.getAdminUserName() ?? "",
                    "password": CashedData.getAdminPassword() as Any
            ]
        }
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
                               //     CashedData.saveAdminPassword(name: Admin.password )
                                    CashedData.saveAdminID(name: Admin.id )
                                    CashedData.saveAdminUserName(name: Admin.username )
                                    AppDelegate.normalUser = false
                                }
                            }
                        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
                        let linkingVC = storyboard.instantiateViewController(withIdentifier: "TabAdminController") as! TabAdminController
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
