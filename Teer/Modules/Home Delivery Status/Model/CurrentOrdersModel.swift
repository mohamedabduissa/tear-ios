//
//  CurrentOrders.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/4/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class CurrentOrdersModel {
    let currentOrdersURL = URL(string: CodeHelper.APIBaseUrl+"new/orders")!
    
    func getCurrentOrders(completion: @escaping (String?, _ order:[CurrentOrdersResponse]?) -> Void) {
            let headers : HTTPHeaders = ["Content-Type": "application/json",
               "Accept": "application/json",
               "Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())"]
               print("dddd",CodeHelper.getCurrentUserToken())
            
               AF.request(currentOrdersURL, method: .get, parameters: nil, encoding : JSONEncoding.default, headers:headers).responseJSON { (response) in
           
                   if response.response?.statusCode == 200{
                   print(response)
                   }
                   switch response.result{
                   case .failure:
                       print("faild")
                   case .success:
                       
                       let json = JSON(response.value!)
                       print(json)
                       var currentOrdersList = [CurrentOrdersResponse]()
                       let currentOrders = json["data"].arrayValue
                       for currentOrder in currentOrders
                       {
                        let key = currentOrder["key"].intValue
                        let price = currentOrder["price"].doubleValue
                        let currentOrder = CurrentOrdersResponse(key: key, price: price)
                        currentOrdersList.append(currentOrder)
                        
                       }

                completion(nil,currentOrdersList)
                    //   print(currentOrdersList[0].key)
               }
               
           
           }
       }
}
