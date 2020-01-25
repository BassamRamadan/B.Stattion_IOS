//
//  CashedData.swift
//
//
//  Created by Hassan Ramadan on 9/25/19.
//  Copyright © 2019 Hassan Ramadan. All rights reserved.
//

import Foundation

class CashedData: NSObject  {
    
    class func saveLanguage(token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "Language")
        def.synchronize()
    }
    class  func getLanguage ()->String {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "Language") as? String ?? "ar" )
    }
    class func saveCountryID(token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "CountryID")
        def.synchronize()
    }
    class  func getCountryID ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "CountryID") as? String)
    }
    class func saveUserApiKey(token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "token")
        def.synchronize()
    }
    class  func getUserApiKey ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "token") as? String)
    }
    class func saveUserUpdateKey (token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "UserUpdateApiKey")
        def.synchronize()
    }
    class  func getUserUpdateKey ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserUpdateApiKey") as? String)
    }
    class func saveUserCode(token:Int){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "code")
        def.synchronize()
    }
    class  func getUserCode ()->Int? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "code") as? Int)
    }
    class func saveUserUpdateCode (token:Int){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "UserUpdateCode")
        def.synchronize()
    }
    class  func getUserUpdateCode ()->Int? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserUpdateCode") as? Int)
    }
    class func saveUserName (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserName")
        def.synchronize()
    }
    class  func getUserName ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserName") as? String)
    }
    
    class func saveUserPhone (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserPhone")
        def.synchronize()
    }
    class func getUserPhone ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserPhone") as? String)
    }
    class  func getUserImage ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserImage") as? String)
    }
    class  func getUserEmail ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserEmail") as? String)
    }
    class  func getUserID ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserID") as? String)
    }
    class func saveUserData (SignAdmin: SignDetails){
        let def = UserDefaults.standard
        def.setValue(SignAdmin.name , forKey: "UserName")
        def.setValue(SignAdmin.phone , forKey: "UserPhone")
        def.setValue(SignAdmin.imagePath , forKey: "UserImage")
        def.setValue(SignAdmin.id , forKey: "UserID")
        if let token = SignAdmin.accessToken{
            def.setValue(token , forKey: "token")
            def.setValue(token , forKey: "UserUpdateApiKey")
        }
        if let token = SignAdmin.code{
            def.setValue(token , forKey: "code")
            def.setValue(token , forKey: "UserUpdateCode")
        }
        def.synchronize()
    }
    
    // for admin
    class func saveAdminApiKey (token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "AdminApiKey")
        def.synchronize()
    }
    class  func getAdminApiKey ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminApiKey") as? String)
    }
    
    
    class func saveAdminUpdateKey (token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "AdminUpdateApiKey")
        def.synchronize()
    }
    class  func getAdminUpdateKey ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminUpdateApiKey") as? String)
    }
    
    
    class func saveAdminPhone (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminPhone")
        def.synchronize()
    }
    class func getAdminPhone ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminPhone") as? String)
    }
    
    
    class func saveAdminCode (Code:Int){
        let def = UserDefaults.standard
        def.setValue(Code , forKey: "AdminCode")
        def.synchronize()
    }
    class  func getAdminCode ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminCode") as? String)
    }
    
    
    class func saveAdminUpdateCode (Code:Int){
        let def = UserDefaults.standard
        def.setValue(Code , forKey: "AdminUpdateCode")
        def.synchronize()
    }
    class  func getAdminUpdateCode ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminUpdateCode") as? String)
    }
    
    
    class func saveAdminUserName (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminUserName")
        def.synchronize()
    }
    class func getAdminUserName ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminUserName") as? String)
    }
    
   
    class func saveAdminName (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminName")
        def.synchronize()
    }
    class func getAdminName ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminName") as? String)
    }
    
    
    class func saveAdminImage (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminImage")
        def.synchronize()
    }
    class  func getAdminImage ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminImage") as? String)
    }
    
    class func saveAdminID (name:Int){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminID")
        def.synchronize()
    }
    class  func getAdminID ()->Int? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminID") as? Int)
    }
    
    class func saveAdminStatus (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "Status")
        def.synchronize()
    }
    class  func getAdminStatus ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "Status") as? String)
    }
    
    class func saveAdminPassword(name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminPassword")
        def.synchronize()
    }
    class func getAdminPassword()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminPassword") as? String)
    }
    
    class func saveAdminData (admin:AdminLoginDetails){
        let def = UserDefaults.standard
        def.setValue(admin.username , forKey: "AdminUserName")
        def.setValue(admin.name , forKey: "AdminName")
        def.setValue(admin.imagePath , forKey: "AdminImage")
        def.setValue(admin.phone , forKey: "AdminPhone")
        def.setValue(admin.status , forKey: "Status")
     //   def.setValue(admin.password , forKey: "AdminPassword")
        def.setValue(admin.id , forKey: "AdminID")
        if let token = admin.accessToken{
            def.setValue(token , forKey: "AdminApiKey")
            def.setValue(token , forKey: "AdminUpdateApiKey")
        }
        def.synchronize()
    }
   
    
    
}
