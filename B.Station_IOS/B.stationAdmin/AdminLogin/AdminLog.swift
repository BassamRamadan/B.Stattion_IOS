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
        login()
    }
    @IBAction func Sign(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AdminSign", bundle: nil)
        let linkingVC = storyboard.instantiateViewController(withIdentifier: "CompanyInfo")
        self.present(linkingVC, animated: true,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title =  "تسجيل شركات النقل"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        setupBackButton()
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
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: AdminLog.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    fileprivate func login() {
        self.loading()
        let url : String = "https://services-apps.net/bstation/public/api/company-login"
        let info : [String : Any] = ["username": name.text ?? "",
                                     "password": password.text ?? ""
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
