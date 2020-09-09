//
//  OrdersHistoryPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/19/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class OrdersHistoryPresenter {

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
        return ordersHistoryList.count
    }
    func configure(cell: OrdersHistoryCollectionViewCell, for index: Int) {
          let currentOrder : OrdersData
          currentOrder = ordersHistoryList[index]
        cell.orderNumber.text = "#" + "\(String(describing: currentOrder.key!))"
        cell.name.text = currentOrder.clientName
        cell.address.text = currentOrder.address
        cell.orderCost.text = currentOrder.price
        cell.orderStatus.text = "\(String(describing: currentOrder.status!))".localize + " at ".localize + "\(String(describing: currentOrder.deliverDate!))"
        
      }
}

protocol OrdersHistoryProtocol: NSObjectProtocol {
    func showError(msg: String)
    func getOrdersHistorySucces()
}
