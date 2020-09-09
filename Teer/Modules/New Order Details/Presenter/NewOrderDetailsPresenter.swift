//
//  NewOrderDetailsPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/10/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class NewOrderDetailsPresenter{
    
    let newOrderDetailsModel: NewOrderDetailsModel
    var newOrderDetailsDelegate: NewOrderDetailsProtocol?
    let toast = ToastMessages()
    init(newOrderDetailsModel: NewOrderDetailsModel) {
        self.newOrderDetailsModel = newOrderDetailsModel
    }
    
    func setVCDelegate(vcDelegate: NewOrderDetailsProtocol?) {
        self.newOrderDetailsDelegate = vcDelegate
    }
    
    func getNewOrderDetails() {
        self.newOrderDetailsModel.getNewOrderDetails(completion: {error , order in
            print("sdsdsdsdsdsd-----------",order!)
            if order != nil {
               // print(CodeHelper.getCurrentUserToken())
                //print("wwwww.....",order!)
                self.newOrderDetailsDelegate?.displayOrderData(order!.orderDetails)
            }
            else{
                self.newOrderDetailsDelegate?.showAlert(msg: "Something went wrong")
            }
            
        })
        
    }
}

protocol NewOrderDetailsProtocol: NSObjectProtocol {
    func showAlert(msg: String)
    func displayOrderData(_ order: (orderNo: Int,
    name: String,
    phone: String,
    address: String,
    price : String,
    clientName:String,
    status : String,
    receivedAtTime: String,
    startedAtTime:String,
    finishedAtTime:String,
    time:String))
}
