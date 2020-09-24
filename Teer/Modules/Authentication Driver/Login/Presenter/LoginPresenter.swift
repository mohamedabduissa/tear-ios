//
//  LoginPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/23/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit

class LoginPresenter {
    
    let loginModel: LoginModel
    var loginVCDelegate: LoginVCProtocol?
    let toast = ToastMessages()
    init(loginModel: LoginModel) {
        self.loginModel = loginModel
    }
    
    func setVCDelegate(vcDelegate: LoginVCProtocol?) {
        self.loginVCDelegate = vcDelegate
    }
    
    func loginWithPhone(phone: String, password: String) {
        self.loginModel.login(phone: phone, password: password, closure: {(user) in
            if user != nil {
                if (user?.email) != "" {
                    print("ssssssss", CodeHelper.getCurrentUserToken())
                    CodeHelper.saveCurrentUserId(userID: (user?.key)!)
                    CodeHelper.saveCurrentUserToken(userToken: (user?.apiToken)!)
                    CodeHelper.saveCurrentUserName(userName: (user?.name)!)
                    CodeHelper.saveCurrentUserEmail(userEmail: (user?.email)!)
                    CodeHelper.saveCurrentUserPhone(userPhone: (user?.phone)!)
                    print(CodeHelper.getCurrentUserId())
                    //TODO: go to the home page transfereing the user object with you
                    Indicator.sharedInstance.hideIndicator()
                    self.loginVCDelegate?.goToHomeScreen()
                    
                }
                else{
                self.loginVCDelegate?.showAlert(msg: "phone_or_password_wrong".localize)
                }
            } else {
                print("error happened!")
                
                self.loginVCDelegate?.showAlert(msg: "phone_or_password_wrong".localize)
            }
        })
    }
    
}

protocol LoginVCProtocol: NSObjectProtocol {
    
    func showAlert(msg: String)
    func goToHomeScreen()
}
