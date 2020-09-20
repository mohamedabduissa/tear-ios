//
//  new_password_presenter.swift
//  Teer
//
//  Created by Boo Doo on 9/17/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
protocol new_passwordVCProtocol: NSObjectProtocol {
    
    func showAlert(msg: String)
    func go_login()
}

class new_password_presenter{
    var forget_password_model: forget_password_model
    var delegate: new_passwordVCProtocol?
    let toast = ToastMessages()
       init(loginModel: forget_password_model) {
           self.forget_password_model = loginModel
       }
       func setVCDelegate(vcDelegate: new_passwordVCProtocol?) {
           self.delegate = vcDelegate
       }
     func verifiy(phone: String, password: String, confirmed_password: String){
        self.forget_password_model.verifiy(phone: phone, password: password, confirmed_password: confirmed_password, closure: { (response) in
                if let response = response{
                      Indicator.sharedInstance.hideIndicator()
                     print("reset\(response)")
                     self.delegate?.showAlert(msg: "passsord_reset_successfully".localize)
                    self.delegate?.go_login()
                }
                else{
                    print("error")
                    print(Error.self)

                    self.delegate?.showAlert(msg: "something_wrong".localize)
                }
            })
        }
   
           
    }
    
