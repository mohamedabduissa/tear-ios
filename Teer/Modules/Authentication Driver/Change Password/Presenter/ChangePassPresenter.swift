//
//  ChangePassPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/30/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit

class ChangePassPresenter {
    
    let changePassModel: ChangePassModel
    var changePassVCDelegate: ChangePassVCProtocol?
    let toast = ToastMessages()
    init(changePassModel: ChangePassModel) {
        self.changePassModel = changePassModel
    }
    
    func setVCDelegate(vcDelegate: ChangePassVCProtocol?) {
        self.changePassVCDelegate = vcDelegate
    }
    
    func changePass(oldPassword: String, newPassword: String, passwordConfirmation: String) {
        self.changePassModel.changePass(oldPassword: oldPassword, password: newPassword, passwordConfirmation: passwordConfirmation, closure: {(response) in
            if response != nil {
                if (response?.status) == 200 {
                    self.changePassVCDelegate?.showAlert(msg: "\(String(describing: response!.message))")
                    print("Password Changed......")
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
                        self.changePassVCDelegate?.goToHomeScreen()
                    }
                }
                else{
                    self.changePassVCDelegate?.showAlert(msg: "\(String(describing: response!.message))")
                }
            } else {
                print("error happened!")
                self.changePassVCDelegate?.showAlert(msg: "\(String(describing: response!.message))")
            }
        })
    }
    
}

protocol ChangePassVCProtocol: NSObjectProtocol {
    
    func showAlert(msg: String)
    func goToHomeScreen()
}
