//
//  AboutUsController.swift
//  TouristGuide
//
//  Created by Bassam Ramadan on 11/2/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit

class UsagePolicy: common {

    @IBOutlet weak var content: UILabel!
    var aboutData: AboutUSDataDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title =   "سياسة الإستخدام"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        common.setNavigationShadow(navigationController: self.navigationController)
        self.tabBarController?.tabBar.isHidden = false
        self.getAboutData()
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func getAboutData() {
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/policies"
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
        AlamofireRequests.getMethod(url: url, headers: headers) { error, success, jsonData in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if success {
                    let dataReceived = try decoder.decode(AboutUS.self, from: jsonData)
                    self.aboutData = dataReceived.data
                    self.content.text = self.aboutData?.content
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
