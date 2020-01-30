//
//  ActivateCompany.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/21/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class ActivateCompany: common {
    var whatsApp : String!
    
    @IBAction func whatApp(_ sender: UIButton) {
        common.callWhats(whats: whatsApp, currentController: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        self.navigationItem.title =  "تفعيل العضوية"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        getContactsData()
     }
    fileprivate func getContactsData() {
        self.loading()
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
        AlamofireRequests.getMethod(url: "https://services-apps.net/bstation/public/api/app-contacts", headers: headers) { error, success, jsonData in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if success{
                    let dataReceived = try decoder.decode(AppContacts.self, from: jsonData)
                    self.whatsApp = dataReceived.data.whatsapp
                } else {
                    let dataReceived = try decoder.decode(ErrorHandle.self, from: jsonData)
                    let alert = common.makeAlert(message: dataReceived.message ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
            } catch {
                let alert = common.makeAlert()
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            }
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
       common.openMain(currentController: self)
    }
    

}
