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
    @IBOutlet var editStack: UIStackView!
    @IBOutlet var EditData: UIView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserData()
        self.navigationItem.title =  "الإعدادات"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func setUserData() {
        if AppDelegate.normalUser {
            EditData.isHidden = true
            name.text = CashedData.getUserName()
            AlamofireRequests.getPhoto(url: (CashedData.getUserImage() ?? "")) { (error , success, image ) in
                self.imageView.image = image
            }
        }else{
            EditData.isHidden = false
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
        let activityController = UIActivityViewController(activityItems: [AppDelegate.stringWithLink], applicationActivities: nil)
        activityController.completionWithItemsHandler = { _, completed, _, _
            in
            if completed {
                print("completed")
            } else {
                print("canceled")
            }
        }
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [AppDelegate.stringWithLink], applicationActivities: nil)
            
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

