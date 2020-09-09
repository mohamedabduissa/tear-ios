//
//  OrdersSearchModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/21/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON


class OrdersSearchModel{
    
    let ordersHistoryURL = URL(string: CodeHelper.APIBaseUrl+"orders/history?date="+CodeHelper.getSelectedDate())!
    
    func getOrdersHistoryByDate(date: String, completion: @escaping (String?, _ order:[OrdersData]?) -> Void) {
        let headers : HTTPHeaders = ["Content-Type": "application/json",
                                     "Accept": "application/json",
                                     "Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())"]
//        let parameters: [String: Any] = [
//            "date" : CodeHelper.getSelectedDate() ,
//        ]
        print("orders/history?&date=",CodeHelper.getCurrentUserToken())
        print(ordersHistoryURL)
        print(CodeHelper.getSelectedDate())
        
        AF.request(ordersHistoryURL, method: .get, parameters: nil, encoding : JSONEncoding.default, headers:headers).responseJSON { (response) in
            
            if response.response?.statusCode == 200{
                print(response)
            }
            switch response.result{
            case .failure:
                print("faild")
            case .success:
                
                let json = JSON(response.value!)
                print(json)
                var ordersHistory = [OrdersData]()
                let orders = json["data"].arrayValue
                for order in orders
                {
                    let key = order["key"].stringValue
                    let clientName = order["clientName"].stringValue
                    let address = order["address"].stringValue
                    let price = order["price"].stringValue
                    let status = order["status"].stringValue
                    let deliverDate = order["deliverDate"].stringValue
                    let orders = OrdersData(key: key, clientName: clientName, address: address, price: price, status: status, deliverDate: deliverDate)
                    ordersHistory.append(orders)                    
                }
                
                completion(nil,ordersHistory)
                //   print(currentOrdersList[0].key)
            }
            
            
        }
    }
}
