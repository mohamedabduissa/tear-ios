//
//  Logout.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/9/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Logout {
    // MARK: LOGOUT API CALL
    /*
     */
    //    func callLogoutAPI()
    //    {
    // UberSupport().showProgressInWindow(viewCtrl: self, showAnimation: true)
    //        var dicts = [AnyHashable: Any]()
    //        dicts["token"] =  Constants().GETVALUE(keyname: USER_ACCESS_TOKEN)
    //        UberAPICalls().PostRequest(dicts as! [String : Any],methodName: METHOD_LOGOUT as NSString, forSuccessionBlock:{(_ response: Any) -> Void in
    //            let gModel = response as! GeneralModel
    //            OperationQueue.main.addOperation {
    //                UberSupport().removeProgress(viewCtrl: self)
    //                if gModel.status_code == "1"
    //                {
    //                    let userDefaults = UserDefaults.standard
    //                    userDefaults.set("", forKey:"getmainpage")
    //                    userDefaults.synchronize()
    //                    self.resetUserLocations()
    //                    userDefaults.removeObject(forKey: USER_CARD_BRAND)
    //                    userDefaults.removeObject(forKey: USER_CARD_LAST4)
    //                    userDefaults.removeObject(forKey: USER_ACCESS_TOKEN)
    //                    Constants().STOREVALUE(value: "Paypal" , keyname: USER_PAYMENT_METHOD)
    //                    Constants().STOREVALUE(value: "Yes" , keyname: USER_SELECT_WALLET)
    //                    self.appDelegate.option = ""
    //                    self.appDelegate.amount = ""
    //                    self.appDelegate.onSetRootViewController(viewCtrl:self)
    //                }
    //                else if gModel.status_code == "2"
    //                {
    //                    let settingsActionSheet: UIAlertController = UIAlertController(title:NSLocalizedString("Message!!!", comment: ""), message:gModel.status_message, preferredStyle:UIAlertController.Style.alert)
    //                    settingsActionSheet.addAction(UIAlertAction(title:NSLocalizedString("Ok", comment: ""), style:UIAlertAction.Style.cancel, handler:{ action in
    //                    }))
    //                    UIApplication.shared.keyWindow?.rootViewController?.present(settingsActionSheet, animated:true, completion:nil)
    //                }
    //                else
    //                {
    //                    if gModel.status_message == "user_not_found" || gModel.status_message == "token_invalid" || gModel.status_message == "Invalid credentials" || gModel.status_message == "Authentication Failed"
    //                    {
    //                        let userDefaults = UserDefaults.standard
    //                        userDefaults.set("", forKey:"getmainpage")
    //                        userDefaults.synchronize()
    //                        self.appDelegate.onSetRootViewController(viewCtrl:self)
    //                    }
    //                    else
    //                    {
    //                        self.appDelegate.createToastMessage(gModel.status_message, bgColor: UIColor.black, textColor: UIColor.white)
    //                    }
    //                }
    //                UberSupport().removeProgressInWindow(viewCtrl: self)
    //            }
    //        }, andFailureBlock: {(_ error: Error) -> Void in
    //            OperationQueue.main.addOperation {
    //                self.appDelegate.createToastMessage(iApp.HamellyError.server.error, bgColor: UIColor.black, textColor: UIColor.white)
    //                UberSupport().removeProgressInWindow(viewCtrl: self)
    //            }
    //        })
    //        self.appDelegate.option = ""
    //        self.appDelegate.amount = ""
    //        self.appDelegate.showLoginView()
    
    let logoutUrl = URL(string: CodeHelper.APIBaseUrl+"user/logout")!
    
    func callLogoutAPI() {
        
        let headers : HTTPHeaders = ["Content-Type": "application/json",
                                     "Accept": "application/json",
                                     "Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())"]
        print("dddd",CodeHelper.getCurrentUserToken())
        AF.request(logoutUrl, method: .post, parameters: nil, encoding : JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            if response.response?.statusCode == 200{
                print(response)
            }
            switch response.result{
            case .failure:
                print("faild")
            case .success:
                
                let json = JSON(response.value!)
                print("logouttttttt...",json)
                CodeHelper.saveCurrentUserToken(userToken: (""))
                CodeHelper.saveCurrentUserId(userID: 0)
                CodeHelper.saveCurrentUserName(userName: "")
                CodeHelper.saveCurrentUserEmail(userEmail: "")
                CodeHelper.saveCurrentUserPhone(userPhone: "")
            }
            
        }
    }
}
