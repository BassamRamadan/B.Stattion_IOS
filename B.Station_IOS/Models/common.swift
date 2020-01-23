//
//  common.swift
//  Tourist-Guide
//
//  Created by mac on 11/28/19.
//  Copyright © 2019 Tamkeen. All rights reserved.
//



import Foundation
import UIKit
import NVActivityIndicatorView
import MOLH
import Firebase

class common : UIViewController , NVActivityIndicatorViewable{
    
    class func openNotify(sender : Any){
        let storyboard = UIStoryboard(name: "MyAccount", bundle: nil)
        let linkingVC = storyboard.instantiateViewController(withIdentifier: "MyAccountViewController")
        (sender as AnyObject).show(linkingVC, sender: sender)
    }
    
    class func drowbackButton()->UIButton {
        let notifBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        notifBtn.setImage(UIImage(named: "ic_back_arrow"), for: [])
        notifBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return notifBtn
        // Do any additional setup after loading the view
    }
    class func openback(sender : UINavigationController){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let linkingVC = storyboard.instantiateViewController(withIdentifier: "LanuchScreenViewController")
                sender.present(linkingVC, animated: true, completion: nil)
                sender.popViewController(animated: true)
                sender.dismiss(animated: true, completion: nil)
    }
    
    class func setNavigationShadow(navigationController: UINavigationController?){
        navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.7
        navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    class func isSaloonLogedin()-> Bool{
        let token = CashedData.getAdminApiKey() ?? ""
        if token.isEmpty{
            return false
        }else{
            return true
        }
        
    }
    class func isUserLogedin()-> Bool{
        let token = CashedData.getUserApiKey() ?? ""
        if token.isEmpty{
            return false
        }else{
            return true
        }
        
    }
    
    class func adminLogout(currentController: UIViewController){
        CashedData.saveAdminApiKey(token: "")
        openMain(currentController: currentController)
    }
    class func userLogout(currentController: UIViewController){
         CashedData.saveUserApiKey(token: "")
         CashedData.saveUserPhone(name: "")
        openMain(currentController: currentController)
    }
    class func openMain(currentController: UIViewController){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
    }
    func loading(_ message:String = ""){
        let size = CGSize(width: 30, height: 30)
        startAnimating(size, message: "", type: NVActivityIndicatorType.lineSpinFadeLoader)
    }
    
    class func makeAlert( message: String = "عفوا حدث خطأ في الاتصال من فضلك حاول مره آخري") -> UIAlertController {
        let alert = UIAlertController(title: "Alert", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default,.cancel,.destructive:
                print("default")
            @unknown default:
                print("default")
            }}))
        return alert
    }
    class func changeLanguage(language: String) {
         
        // change the language.
        MOLH.setLanguageTo(language)
        MOLHLanguage.setDefaultLanguage(language)
    }
    
    class func ConvertImageToBase64String (img: UIImage) -> String {
        let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }

    //
    // Convert a base64 representation to a UIImage
    //
    class func ConvertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image  ?? #imageLiteral(resourceName: "test")
    }
}
