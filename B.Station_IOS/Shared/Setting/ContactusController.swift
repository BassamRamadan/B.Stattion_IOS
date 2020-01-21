//
//  ContactusController.swift
//  salonatcom
//
//  Created by mac on 10/27/19.
//  Copyright © 2019 Tamkeen. All rights reserved.
//

import UIKit

class ContactusController: common {
    
    var userType: String?
    var token: String?

    
    @IBOutlet var name : UITextField!
    @IBOutlet var phone : UITextField!
    @IBOutlet var email : UITextField!
    @IBOutlet var body : UITextView!
    @IBOutlet var send : UIButton!
    @IBAction func SendSuggestion(_ sender: Any?) {
        AlamofireUpload("https://services-apps.net/bstation/public/api/contact-us")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShadowViewtop()
        Modules()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ok(reg:)))
        view.addGestureRecognizer(tap)
        setUserData()
    }
    @objc func ok(reg : UITapGestureRecognizer){
        view.endEditing(true)
    }
    fileprivate func Modules(){
        name.delegate = self
        phone.delegate = self
        setModules(name)
        setModules(phone)
        setModules(body)
    }
    fileprivate func setModules(_ textField : UIView){
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
    }
    
    fileprivate func setUserData(){
        if AppDelegate.normalUser {
            name.text = CashedData.getUserName()
        }else{
            name.text = CashedData.getAdminName()
        }
    }
    fileprivate func AlamofireUpload(_ url : String){
        self.loading()
        let headers = ["Content-Type": "application/json" ,
                       "Accept" : "application/json",
                       "Authorization": "Bearer \(token ?? "")"
        ]
        let parameters = [
            "name": name.text!,
            "phone": phone.text!,
            "message": body.text!
            ] as [String : Any]
        AlamofireRequests.PostMethod(methodType: "POST", url: url, info: parameters, headers: headers) {
            (error, success , jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if success{
                    self.body.text = ""
                    let alert = common.makeAlert( message: "تم الارسال بنجاح")
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                    let alert = common.makeAlert(message: dataRecived.message ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
                
            } catch {
                let alert = common.makeAlert()
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            }
        }
    }
    
    func getApiToken() {
        if AppDelegate.normalUser {
            self.name.text = CashedData.getUserName()
            token = CashedData.getUserApiKey() ?? ""
        }else{
            self.name.text = CashedData.getAdminName()
            token = CashedData.getAdminApiKey() ?? ""
        }
    }
    
    
    
   
    @objc func back(){
        print("accessed")
        common.openback(sender: self.navigationController!)
    }
    fileprivate func setupShadowViewtop(){
        common.setNavigationShadow(navigationController: self.navigationController)
    }
}
extension ContactusController : UITextFieldDelegate {
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
extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
        }
        set {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
}
