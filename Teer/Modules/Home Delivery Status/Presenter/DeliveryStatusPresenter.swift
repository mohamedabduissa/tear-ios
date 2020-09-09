//
//  DeliveryStatusPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/25/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class DeliveryStatusPresenter{
    
    let deliveryModel: DeliveryStatusModel
    var deliveryStatusDelegate: DeliveryStatusProtocol?
    let toast = ToastMessages()
    init(deliveryModel: DeliveryStatusModel) {
        self.deliveryModel = deliveryModel
    }
    
    func setVCDelegate(vcDelegate: DeliveryStatusProtocol?) {
        self.deliveryStatusDelegate = vcDelegate
    }
    
    func orderCountableByStatus() {
        self.deliveryModel.orderCountableByStatus(completion: {error , order in
            print("sdsdsdsdsdsd-----------",order!)
            if order != nil {
               // print(CodeHelper.getCurrentUserToken())
                //print("wwwww.....",order!)
                self.deliveryStatusDelegate?.displayOrderData(order!.order)
            }
            else{
                self.deliveryStatusDelegate?.showAlert(msg: "Something went wrong")
            }
            
        })
        
    }
}

protocol DeliveryStatusProtocol: NSObjectProtocol {
    func showAlert(msg: String)
    func displayOrderData(_ order: (new: Int,complete: Int, processing : Int, cancel: Int))
}
