//
//  OrdersHistoryPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/19/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class OrdersHistoryPresenter {
    var filterd = [OrdersData]()
   var num = ""
        let ordersHistoryModel: OrdersHistoryModel
        var ordersHistoryDelegate: OrdersHistoryProtocol?
        var ordersHistoryList : [OrdersData]
        let toast = ToastMessages()
        init(ordersHistoryModel: OrdersHistoryModel) {
            self.ordersHistoryModel = ordersHistoryModel
            ordersHistoryList = [OrdersData]()
        }
        
        func setVCDelegate(vcDelegate: OrdersHistoryProtocol?) {
            self.ordersHistoryDelegate = vcDelegate
        }
        
//        func getAllOrdersHistory() {
//            self.ordersHistoryModel.getAllOrdersHistory(completion: {error , ordersHistory in
//
//                if ordersHistory != nil && ordersHistory?.count != 0 {
//                   // print(CodeHelper.getCurrentUserToken())
//                    //print("wwwww.....",order!)
//                    self.ordersHistoryList = ordersHistory!
//                    self.ordersHistoryDelegate?.getOrdersHistorySucces()
//                }
//                else{
//                    self.ordersHistoryDelegate?.showError(msg: "Something went wrong")
//                }
//
//            })
//
//        }
//
    
    
    
    func getAllOrdersHistoryBYStatus(status: String) {
        var ordersURL = URL(string: CodeHelper.APIBaseUrl+"orders/history")!
               switch status {
               case "cancel":
                     ordersURL = URL(string: CodeHelper.APIBaseUrl+"orders/history?status=cancel")!

               case "complete":
                     ordersURL = URL(string: CodeHelper.APIBaseUrl+"orders/history?status=complete")!
               case "processing":
                ordersURL = URL(string: CodeHelper.APIBaseUrl+"orders/history?status=processing")!
               default:
                    ordersURL = URL(string: CodeHelper.APIBaseUrl+"orders/history")!

                   
               }
          
        self.ordersHistoryModel.getAllOrdersHistoryByStatus(url: ordersURL, completion: {error , ordersHistory in
                if ordersHistory != nil && ordersHistory?.count != 0 {
                    
                    self.ordersHistoryList = ordersHistory!
                    self.ordersHistoryDelegate?.getOrdersHistorySucces()
                }
                else{
                    self.ordersHistoryDelegate?.showError(msg: "Something went wrong")
                }
                
            })
        
    }
    
    func getAllOrdersHistoryCount()-> Int
    {
        return ordersHistoryList.count


    }
    func configure(cell: OrdersHistoryCollectionViewCell, for index: Int) {
        var currentOrder: OrdersData

        if filterd.count == 0 {
            currentOrder = ordersHistoryList[index]

        }
        else
        {
            currentOrder = filterd[index]

        }
//          currentOrder = filterd[index]

        cell.orderNumber.text = "#" + "\(String(describing: currentOrder.key!))"
        cell.name.text = currentOrder.clientName
        cell.address.text = currentOrder.address
        cell.orderCost.text = currentOrder.price
        cell.orderCost.text?.append(contentsOf: " SAR".localize)
        cell.orderStatus.text = "\(String(describing: currentOrder.status!))".localize + " at ".localize + "\(String(describing: currentOrder.deliverDate!))"
      }
    
    func return_number(cell: OrdersHistoryCollectionViewCell, for index: Int) -> String
    {
        var currentOrder: OrdersData
        
        if filterd.count == 0 {
            currentOrder = ordersHistoryList[index]
            
        }
        else
        {
            currentOrder = filterd[index]
            
        }
        return  currentOrder.key!
        
    }
    
    
}

protocol OrdersHistoryProtocol: NSObjectProtocol {
    func showError(msg: String)
    func getOrdersHistorySucces()
}
