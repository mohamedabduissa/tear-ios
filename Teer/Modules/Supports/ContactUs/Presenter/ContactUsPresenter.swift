//
//  ContactUsPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/17/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit

class ContactUsPresenter {
    
    let contactModel: ContactUsModel
    var contactUsVCDelegate: ContactUsVCProtocol?
    let toast = ToastMessages()
    init(contactModel: ContactUsModel) {
        self.contactModel = contactModel
    }
    
    func setVCDelegate(vcDelegate: ContactUsVCProtocol?) {
        self.contactUsVCDelegate = vcDelegate
    }
    
    func contactUS(title: String, type: String, message: String) {
        self.contactModel.contactUs(title: title, type: type, message: message,closure: {(contact) in
            print("user data ....",contact)
            if contact != nil {
                if (contact?.message) != "The given data was invalid." {
                    if (contact?.status) != nil{
                    //CodeHelper.saveCurrentUserId(userID: (user?.key)!)
                    //CodeHelper.saveCurrentUserToken(userToken: (user?.apiToken)!)
                    //print(CodeHelper.getCurrentUserId())
                    //TODO: go to the home page transfereing the user object with you
                        self.contactUsVCDelegate?.showAlert(msg: "message has been sent successfully.")
                        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                            self.contactUsVCDelegate?.goToHomeScreen()
                        }
                }
                }
                else{
                    self.contactUsVCDelegate?.showAlert(msg: "\(contact?.message ?? "Something went wrong")")
                }
            } else {
                print("error happened!")
                
                self.contactUsVCDelegate?.showAlert(msg: "\(contact?.message ?? "Something went wrong")")
            }
        })
    }
    
}

protocol ContactUsVCProtocol: NSObjectProtocol {
    
    func showAlert(msg: String)
    func goToHomeScreen()
}
