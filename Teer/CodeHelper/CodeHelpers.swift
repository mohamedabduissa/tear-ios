//
//  CodeHelpers.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/23/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
final class CodeHelper{
    static let appName = "Teer"
    static let appLogo = ""
    
    enum ServerTypes : String{
        case live = "http://api-ksa.com/demo/taar/"
        //case demo = "http://api-ksa.com/demo/taar/"
    }
    
    private init(){}
    static let baseURL : ServerTypes = .live
    static let APIBaseUrl = CodeHelper.baseURL.rawValue + "api/v1/"
    
    //MARK:- UserID
    static let USER_ID_KEY = "userId"
    static func saveCurrentUserId(userID: Int){
        UserDefaults.standard.set(userID, forKey: USER_ID_KEY)
    }
    static func getCurrentUserId() -> Int {
        return UserDefaults.standard.integer(forKey: USER_ID_KEY)
    }
    
    //MARK:- UserToken
    static let USER_DEVICE_TOKEN = "userToken"
    static func saveCurrentUserToken(userToken: String){
        UserDefaults.standard.set(userToken, forKey: USER_DEVICE_TOKEN)
    }
    static func getCurrentUserToken() -> String {
        return UserDefaults.standard.string(forKey: USER_DEVICE_TOKEN) ?? "00"
    }
    
    //MARK:- UserName
    static let USER_NAME = "name"
    static func saveCurrentUserName(userName: String){
        UserDefaults.standard.set(userName, forKey: USER_NAME)
    }
    static func getCurrentUserName() -> String {
        return UserDefaults.standard.string(forKey: USER_NAME) ?? ""
    }
    //MARK:- UserEmail
    static let USER_EMAIL = "email"
    static func saveCurrentUserEmail(userEmail: String){
        UserDefaults.standard.set(userEmail, forKey: USER_EMAIL)
    }
    static func getCurrentUserEmail() -> String {
        return UserDefaults.standard.string(forKey: USER_EMAIL) ?? ""
    }
    //MARK:- UserPhone
    static let USER_PHONE = "phone"
    static func saveCurrentUserPhone(userPhone: String){
        UserDefaults.standard.set(userPhone, forKey: USER_PHONE)
    }
    static func getCurrentUserPhone() -> String {
        return UserDefaults.standard.string(forKey: USER_PHONE) ?? ""
    }
    //MARK:- currentDate
    static let SELECTED_DATE = "date"
    static func saveSelectedDate(selecteDate: String){
        UserDefaults.standard.set(selecteDate, forKey: SELECTED_DATE)
    }
    static func getSelectedDate() -> String {
        return UserDefaults.standard.string(forKey: SELECTED_DATE) ?? ""
    }
}
extension String{
    var localize: String{
        return NSLocalizedString(self, comment: "")
    }
}
