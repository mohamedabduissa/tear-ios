//
//  RetrieveingOrderPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/15/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class RetrieveingOrderPresenter{
    let retrieveingOrderModel: RetrieveingOrderModel
        var retrieveingOrderDelegate: RetrieveingOrderProtocol?
        let toast = ToastMessages()
        init(retrieveingOrderModel: RetrieveingOrderModel) {
            self.retrieveingOrderModel = retrieveingOrderModel
        }
        
        func setVCDelegate(vcDelegate: RetrieveingOrderProtocol?) {
            self.retrieveingOrderDelegate = vcDelegate
        }
        
    func submitRetrieveingOrder(reason:String, status: String) {
        self.retrieveingOrderModel.submitRetrieveingOrderReason(retrieveingReason:reason, status: status,completion: {error in
                if error == nil {
                   // print(CodeHelper.getCurrentUserToken())
                    //print("wwwww.....",order!)
                    self.retrieveingOrderDelegate?.displayOrderData()
                }
                else{
                    self.retrieveingOrderDelegate?.showAlert(msg: "Something went wrong")
                }
                
            })
            
        }
    }

    protocol RetrieveingOrderProtocol: NSObjectProtocol {
        func showAlert(msg: String)
        func displayOrderData()
    }
