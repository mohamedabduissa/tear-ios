
//
//  forget_password_presenter.swift
//  Teer
//
//  Created by Boo Doo on 9/13/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit

class forget_password_presenter {
    
    let forget_password_model: forget_password_model
    var forget_password_VCDelegate: forget_passwordVCProtocol?
    let toast = ToastMessages()
       init(loginModel: forget_password_model) {
           self.forget_password_model = loginModel
       }
       
       func setVCDelegate(vcDelegate: forget_passwordVCProtocol?) {
           self.forget_password_VCDelegate = vcDelegate
       }
    func forget(phone: String){
        self.forget_password_model.forget_password(phone: phone, closure: {(verifiy_code) in
            if let verifiy_code = verifiy_code{
                if verifiy_code.code != nil{
                   
                    Indicator.sharedInstance.hideIndicator()
                    self.forget_password_VCDelegate?.go_verification(code: verifiy_code.code!)
                }
            }
            else{
                print("error")
                print(Error.self)
                
                self.forget_password_VCDelegate?.showAlert(msg: "something_wrong".localize)
            }
        })
    }
   
       
}
protocol forget_passwordVCProtocol: NSObjectProtocol {
    
    func showAlert(msg: String)
    func go_verification(code: Int)
}
