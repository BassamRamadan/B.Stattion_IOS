//
//  GuideLogin.swift
//  Tourist-Guide
//
//  Created by mac on 11/28/19.
//  Copyright © 2019 Tamkeen. All rights reserved.
//
import UIKit

class UserLogin: common {
    
    @IBOutlet weak var astric: UILabel!
    @IBOutlet weak var Submit: UIButton!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var OldUser: UIButton!
    @IBOutlet weak var NewUser: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBAction func Old(_ sender: Any) {
        if CashedData.getUserPhone() != ""{
            phone.text = CashedData.getUserPhone()
        }
        Label.isHidden = false
        astric.isHidden = false
        name.isHidden = true
        Submit.setTitle("دخول", for: .normal)
        NewUser.backgroundColor = UIColor(named: "dark light")
        OldUser.backgroundColor = UIColor.white
        
    }
    @IBAction func New(_ sender: Any) {
        phone.text = ""
        Label.isHidden = true
        astric.isHidden = true
        name.isHidden = false
        Submit.setTitle("تسجيل", for: .normal)
        OldUser.backgroundColor = UIColor(named: "dark light")
        NewUser.backgroundColor = UIColor.white
    }
 
    @IBAction func Submit(_ sender: Any) {
        if name.isHidden == true{
            login("oldUser")
        }else{
            login("newUser")
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CashedData.saveUserCode(token: 4633)
        CashedData.saveUserPhone(name: "01025961815")
        Old(OldUser as Any)
        Modules()
        setModules(name)
        setModules(phone)
    }
    fileprivate func Modules(){
        name.delegate = self
        phone.delegate = self
        setModules(name)
        setModules(phone)
    }
    fileprivate func setModules(_ textField : UIView){
        textField.backgroundColor = UIColor(named: "textFieldBackground")
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.0
    }
    @IBAction func remeperMe(_ sender: UIButton) {
        
        if sender.isSelected == true {
            sender.setImage(UIImage(named: "checked"), for: .normal)
        }
        else {
            sender.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        sender.isSelected = !sender.isSelected
        
    }
    fileprivate func login(_ userType : String) {
        self.loading()
        var url : String
        var info : [String : Any]
        if userType == "newUser"{
            url = "https://services-apps.net/bstation/public/api/user-signup"
            info = ["name": name.text!,
                    "phone":phone.text!
            ]
        }else{
            url = "https://services-apps.net/bstation/public/api/user-login"
            info = ["phone": CashedData.getUserPhone() ?? "",
                    "code": CashedData.getUserCode() as Any
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
                        if userType == "newUser"{
                            let dataRecived = try decoder.decode(UserSign.self, from: jsonData)
                            if dataRecived.code >= 201 && dataRecived.code < 300{
                                if let user = dataRecived.data{
                                    CashedData.saveUserApiKey(token: (user.accessToken ?? ""))
                                    CashedData.saveUserUpdateKey(token: (user.accessToken ?? ""))
                                    CashedData.saveUserData(SignAdmin: user)
                                    CashedData.saveUserCode(token: Int(user.code!) )
                                    CashedData.saveUserUpdateCode(token: Int(user.code!) )
                                    CashedData.saveUserPhone(name: user.phone)
                                }
                            }
                        }
                        let storyboard = UIStoryboard(name: "User", bundle: nil)
                        let linkingVC = storyboard.instantiateViewController(withIdentifier: "TabUserController") as! TabUserController
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

extension UserLogin : UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
     }
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        return true
     }
     func textFieldDidEndEditing(_ textField: UITextField) {
        setModules(textField)
     }
 }
