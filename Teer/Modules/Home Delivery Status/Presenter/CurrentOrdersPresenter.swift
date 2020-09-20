//
//  CurrentOrdersPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/4/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class CurrentOrdersPresenter {

        let currnetOrdersModel: CurrentOrdersModel
        var currentOrdersDelegate: CurrentOrdersProtocol?
        var currentOrdersList : [CurrentOrdersResponse]
        let toast = ToastMessages()
        init(currnetOrdersModel: CurrentOrdersModel) {
            self.currnetOrdersModel = currnetOrdersModel
            currentOrdersList = [CurrentOrdersResponse]()
        }
        
        func setVCDelegate(vcDelegate: CurrentOrdersProtocol?) {
            self.currentOrdersDelegate = vcDelegate
        }
        
        func getCurrentOrders() {
            self.currnetOrdersModel.getCurrentOrders(completion: {error , currentOrders in
                print("sdsdsdsdsdsd-----------")
               
                if currentOrders != nil && currentOrders?.count != 0 {
                   // print(CodeHelper.getCurrentUserToken())
                    //print("wwwww.....",order!)
                    self.currentOrdersList = currentOrders!
                    self.currentOrdersDelegate?.getCurrentOrdersSucces()
                }
                else{
                    self.currentOrdersDelegate?.showError(msg: "Something went wrong")
                }
                
            })
            
        }
    
    func getCurrentOrdersCount()-> Int
    {
        return currentOrdersList.count
    }
    func configure(cell: CurrentOrdersCellProtocol, for index: Int) {
          let currentOrder : CurrentOrdersResponse
          currentOrder = currentOrdersList[index]
          cell.displayOrderNumber(number:currentOrder.key)
          cell.displayOrderPrice(price: currentOrder.price)
//        CurrentOrdersResponse.save("\(currentOrder.key)")
      }
    func request_number(for index: Int) -> String
    {
        let currentOrder : CurrentOrdersResponse
        currentOrder = currentOrdersList[index]
        return "\(currentOrder.key)"
        
    }
}

protocol CurrentOrdersProtocol: NSObjectProtocol {
    func showError(msg: String)
    func getCurrentOrdersSucces()
}
