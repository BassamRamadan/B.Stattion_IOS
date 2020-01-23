//
//  ActivateCompany.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/21/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class ActivateCompany: UIViewController {
    @IBOutlet weak var appPhone: UILabel!
    @IBOutlet weak var appWhats: UILabel!
    @IBOutlet weak var appTelegram: UIButton!
    
    @IBAction func whatApp(_ sender: UIButton) {
       
    }
    @IBAction func CallApp(_ sender: UIButton) {
    }
    
    @IBAction func telegramApp(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  getContactsData()
     }
    fileprivate func getContactsData() {
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
        AlamofireRequests.getMethod(url: "https://services-apps.net/bstation/public/api/app-contacts", headers: headers) { error, success, jsonData in
            do {
                let decoder = JSONDecoder()
                if success{
                    let dataReceived = try decoder.decode(AppContacts.self, from: jsonData)
                    self.appPhone.text = dataReceived.data.phone
                    self.appWhats.text = dataReceived.data.whatsapp
                    self.appTelegram.setTitle(dataReceived.data.telegram,for: .normal)
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

    

}
