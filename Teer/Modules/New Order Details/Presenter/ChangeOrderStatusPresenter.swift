//
//  ChangeOrderStatusPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/11/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class ChangeOrderStatusPresenter {
     let changeOrderStatusModel: ChangeOrderStatusModel
        var changeOrderStatusProtocol: ChangeOrderStatusProtocol?
        let toast = ToastMessages()
        init(changeOrderStatusModel: ChangeOrderStatusModel) {
            self.changeOrderStatusModel = changeOrderStatusModel
        }
        
        func setVCDelegate(vcDelegate: ChangeOrderStatusProtocol?) {
            self.changeOrderStatusProtocol = vcDelegate
        }
        
    func changeOrderStatus(status:String,caneclReson:String) {
        self.changeOrderStatusModel.changeOrderStatus(status:status,cancelReson: caneclReson, completion: {error , order in
                print("sdsdsdsdsdsd-----------",order!)
                if order != nil {
                   // print(CodeHelper.getCurrentUserToken())
                    //print("wwwww.....",order!)
                    self.changeOrderStatusProtocol?.changeOrderStatusSuccess()
                }
                else{
                    self.changeOrderStatusProtocol?.showError(msg: "Something went wrong")
                }
                
            })
            
        }
    }
protocol ChangeOrderStatusProtocol: NSObjectProtocol {
        func showError(msg: String)
        func changeOrderStatusSuccess()
    }
