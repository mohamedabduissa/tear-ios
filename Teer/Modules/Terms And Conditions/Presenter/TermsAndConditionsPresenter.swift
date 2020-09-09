//
//  TermsAndConditionsPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/16/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class TermsAndConditionsPresenter {
    let termsAndConditionsModel: TermsAndConditionsModel
            var changeOrderStatusDelegate: TermsAndConditionsProtocol?
            let toast = ToastMessages()
            init(termsAndConditionsModel: TermsAndConditionsModel) {
                self.termsAndConditionsModel = termsAndConditionsModel
            }
            
            func setVCDelegate(vcDelegate: TermsAndConditionsProtocol?) {
                self.changeOrderStatusDelegate = vcDelegate
            }
            
        func termsAndConditions() {
            self.termsAndConditionsModel.termsAndConditions(completion: {error , data in
                    print("sdsdsdsdsdsd-----------",data!)
                    if data != nil {
                       // print(CodeHelper.getCurrentUserToken())
                        //print("wwwww.....",order!)
                        self.changeOrderStatusDelegate?.termsAndConditions(data: data!)
                    }
                    else{
                        self.changeOrderStatusDelegate?.showError(msg: "Something went wrong")
                    }
                    
                })
                
            }
        }
    protocol TermsAndConditionsProtocol: NSObjectProtocol {
            func showError(msg: String)
        func termsAndConditions(data:String)
        }
