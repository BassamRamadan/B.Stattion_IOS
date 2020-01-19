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
    class func saveUserName (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserName")
        def.synchronize()
    }
    class  func getUserName ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserName") as? String)
    }
    
    class func saveUserPassword (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserPassword")
        def.synchronize()
    }
    class func getUserPassword ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserPassword") as? String)
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
    class func saveUserData (admin:User){
        let def = UserDefaults.standard
        def.setValue(admin.name , forKey: "UserName")
        def.setValue(admin.username , forKey: "UserUserName")
        def.setValue(admin.imagePath , forKey: "UserImage")
        def.setValue(admin.email , forKey: "UserEmail")
        def.setValue(admin.id , forKey: "UserID")
        if let token = admin.accessToken{
            def.setValue(token , forKey: "token")
            def.setValue(token , forKey: "UserUpdateApiKey")
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
    class  func getAdminImage ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminImage") as? String)
    }
    class  func getAdminEmail ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminEmail") as? String)
    }
    class  func getAdminID ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminID") as? String)
    }
    class  func getAdminCode ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminCode") as? String)
    }
    class  func getBalance ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminBalance") as? String)
    }
    class  func getBalanceRewards ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminBalanceRewards") as? String)
    }
    class  func getBalanceInvitations ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminbalanceInvitations") as? String)
    }
    class func saveAdminData (admin:User){
        let def = UserDefaults.standard
        def.setValue(admin.name , forKey: "AdminName")
        def.setValue(admin.username , forKey: "AdminUserName")
        def.setValue(admin.imagePath , forKey: "AdminImage")
        def.setValue(admin.email , forKey: "AdminEmail")
        def.setValue(admin.id , forKey: "AdminID")
        def.setValue(admin.code , forKey: "AdminCode")
        def.setValue(admin.balance , forKey: "AdminBalance")
        def.setValue(admin.balanceRewards , forKey: "AdminBalanceRewards")
        def.setValue(admin.balanceInvitations , forKey: "AdminbalanceInvitations")
        if let token = admin.accessToken{
            def.setValue(token , forKey: "AdminApiKey")
            def.setValue(token , forKey: "AdminUpdateApiKey")
        }
        def.synchronize()
    }
    class func saveAdminName (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminName")
        def.synchronize()
    }
    class  func getAdminName ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminName") as? String)
    }
    class func saveAdminPassword(name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminPassword")
        def.synchronize()
    }
    class func getAdminPassword()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminnPassword") as? String)
    }
}
