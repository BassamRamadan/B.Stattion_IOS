//
//  GuideLogin.swift
//  Tourist-Guide
//
//  Created by mac on 11/28/19.
//  Copyright © 2019 Tamkeen. All rights reserved.
//
import UIKit

class UserLogin: common {
    
    @IBOutlet weak var Submit: UIButton!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var OldUser: UIButton!
    @IBOutlet weak var NewUser: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBAction func Old(_ sender: Any) {
        Label.isHidden = false
        name.isHidden = true
        Submit.setTitle("تسجيل", for: .normal)
    }
    @IBAction func New(_ sender: Any) {
        Label.isHidden = true
        name.isHidden = false
        Submit.setTitle("دخول", for: .normal)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setModules(name)
        setModules(phone)
    }
    fileprivate func setModules(_ textField : UIView){
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
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
    
    @IBAction func login(_ sender: UIButton) {
        let url = "https://services-apps.net/bstation/public/api/user-signup"
        let info = ["name": name.text!,
                    "phone":phone.text!
        ]
        
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        AlamofireRequests.PostMethod( methodType: "POST", url: url, info: info, headers: headers) { (error, success , jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        let dataRecived = try decoder.decode(UserProfile.self, from: jsonData)
                        if dataRecived.code >= 201 && dataRecived.code < 300{
                            if let user = dataRecived.data{
                                CashedData.saveAdminApiKey(token: (user.accessToken ?? ""))
                                CashedData.saveAdminUpdateKey(token: (user.accessToken ?? ""))
                                CashedData.saveAdminData(admin: user)
                                CashedData.saveAdminPassword(name: self.phone.text!)
                            }
                            let storyboard = UIStoryboard(name: "User", bundle: nil)
                            let linkingVC = storyboard.instantiateViewController(withIdentifier: "TabUserController") as! TabUserController
                            linkingVC.index = 4
                            self.present(linkingVC, animated: false, completion: nil)
                        }}
                    else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    }}
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
