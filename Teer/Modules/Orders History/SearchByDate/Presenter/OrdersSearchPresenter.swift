//
//  OrdersSearchPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/21/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class OrdersSearchPresenter {

        let ordersSearchModel: OrdersSearchModel
        var ordersSearchDelegate: OrdersSearchProtocol?
        var ordersSearchList : [OrdersData]
        let toast = ToastMessages()
        init(ordersSearchModel: OrdersSearchModel) {
            self.ordersSearchModel = ordersSearchModel
            ordersSearchList = [OrdersData]()
        }
        
        func setVCDelegate(vcDelegate: OrdersSearchProtocol?) {
            self.ordersSearchDelegate = vcDelegate
        }
        
    func getAllOrdersSearch(date: String) {
        self.ordersSearchModel.getOrdersHistoryByDate(date: date, completion: {error , ordersSearch in
               
                if ordersSearch != nil && ordersSearch?.count != 0 {
                   // print(CodeHelper.getCurrentUserToken())
                    //print("wwwww.....",order!)
                    self.ordersSearchList = ordersSearch!
                    self.ordersSearchDelegate?.getOrdersSearchSucces()
                    CodeHelper.saveSelectedDate(selecteDate: "")
                }
                else{
                    self.ordersSearchDelegate?.showError(msg: "Something went wrong")
                }
                
            })
            
        }
    
    func getAllOrdersSearchCount()-> Int
    {
        return ordersSearchList.count
    }
    func configure(cell: OrdersHistoryCollectionViewCell, for index: Int) {
          let currentOrder : OrdersData
          currentOrder = ordersSearchList[index]
        cell.orderNumber.text = "#" + "\(String(describing: currentOrder.key!))"
//        cell.orderNumber.text = "#" + "123"
        cell.name.text = currentOrder.clientName
        cell.address.text = currentOrder.address
        cell.orderCost.text = currentOrder.price
        cell.orderCost.text?.append(contentsOf: " SAR".localize)
        cell.orderStatus.text = "\(String(describing: currentOrder.status!))".localize + " at ".localize + "\(String(describing: currentOrder.deliverDate!))"
        
      }
}

protocol OrdersSearchProtocol: NSObjectProtocol {
    func showError(msg: String)
    func getOrdersSearchSucces()
}
