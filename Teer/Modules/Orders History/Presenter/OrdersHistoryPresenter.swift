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
     public var type = ""
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
        
        func getAllOrdersHistory() {
            self.ordersHistoryModel.getAllOrdersHistory(completion: {error , ordersHistory in
               
                if ordersHistory != nil && ordersHistory?.count != 0 {
                   // print(CodeHelper.getCurrentUserToken())
                    //print("wwwww.....",order!)
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

        print("inside coun")
        switch type {
        case "cancel":
//            let oredr = ordersHistoryList
            filterd = ordersHistoryList.filter { $0.status == "cancel" }
            return filterd.count
        case "complete":
            filterd = ordersHistoryList.filter { $0.status == "complete" }
            return filterd.count
        case "processing":
            filterd = ordersHistoryList.filter { $0.status == "processing" }
            return filterd.count
        default:
            return ordersHistoryList.count
        }

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
