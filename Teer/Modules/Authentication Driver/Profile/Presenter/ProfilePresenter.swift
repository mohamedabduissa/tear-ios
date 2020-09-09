//
//  ProfilePresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/16/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit

class ProfilePresenter {
    
    let profileModel: ProfileModel
    var profileVCDelegate: ProfileVCProtocol?
    let toast = ToastMessages()
    init(profileModel: ProfileModel) {
        self.profileModel = profileModel
    }
    
    func setVCDelegate(vcDelegate: ProfileVCProtocol?) {
        self.profileVCDelegate = vcDelegate
    }
    
    func profileUpdate(name: String, email: String, phone: String) {
        self.profileModel.profileUpdate(name: name, email: email,phone: phone, closure: {(profile) in
            print("user data ....",profile)
            if profile != nil {
                if (profile?.email) != "" {
                    //CodeHelper.saveCurrentUserId(userID: (user?.key)!)
                    //CodeHelper.saveCurrentUserToken(userToken: (user?.apiToken)!)
                    //print(CodeHelper.getCurrentUserId())
                    //TODO: go to the home page transfereing the user object with you
                    CodeHelper.saveCurrentUserName(userName: (profile?.name)!)
                    CodeHelper.saveCurrentUserEmail(userEmail: (profile?.email)!)
                    CodeHelper.saveCurrentUserPhone(userPhone: (profile?.phone)!)
                    self.profileVCDelegate?.showAlert(msg: "Data Changed Successfully")
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                        self.profileVCDelegate?.goToHomeScreen()
                    }
                }
                else{
                self.profileVCDelegate?.showAlert(msg: "Something went wrong")
                }
            } else {
                print("error happened!")
                
                self.profileVCDelegate?.showAlert(msg: "Something went wrong")
            }
        })
    }
    
}

protocol ProfileVCProtocol: NSObjectProtocol {
    
    func showAlert(msg: String)
    func goToHomeScreen()
}
