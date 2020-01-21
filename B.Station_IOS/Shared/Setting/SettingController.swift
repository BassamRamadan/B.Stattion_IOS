//
//  MoreController.swift
//  Tourist-Guide
//
//  Created by Bassam Ramadan on 11/8/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit
import DropDown
class SettingController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    private final let stringWithLink = "Please download Tourist Guide app here from Tamkeen Site: http://support@tamkeen-apps.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserData()
        // Do any additional setup after loading the view.
    }
    
    func setUserData() {
        if AppDelegate.normalUser {
            name.text = CashedData.getUserName()
            AlamofireRequests.getPhoto(url: (CashedData.getUserImage() ?? "")) { (error , success, image ) in
                self.imageView.image = image
            }
        }else{
            name.text = CashedData.getAdminName()
            AlamofireRequests.getPhoto(url: (CashedData.getAdminImage() ?? "")) { (error , success, image ) in
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func logoutUser(_ sender: Any){
        common.userLogout(currentController: self)
        
    }
    @IBAction func shareAppAction(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [stringWithLink], applicationActivities: nil)
        activityController.completionWithItemsHandler = { _, completed, _, _
            in
            if completed {
                print("completed")
            } else {
                print("canceled")
            }
        }
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [stringWithLink], applicationActivities: nil)
            
            // ios > 8.0
            if activityVC.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                activityVC.popoverPresentationController?.sourceView = super.view
                
                //                activityVC.popoverPresentationController?.sourceRect = super.view.frame
            }
            present(activityVC, animated: true, completion: nil)
        } else {
            present(activityController, animated: true) {
                print("presented")
            }
        }
    }
    
    @IBAction func editMyData(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserSignup", bundle: nil)
        let linkingVC = storyboard.instantiateViewController(withIdentifier: "UserEditDataNavigation") as! UINavigationController
        self.present(linkingVC, animated: true, completion: nil)
    }
}

