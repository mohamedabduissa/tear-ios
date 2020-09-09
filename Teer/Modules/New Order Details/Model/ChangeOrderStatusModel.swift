//
//  ChangeStatusModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/11/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ChangeOrderStatusModel {
    
    let changeOrderStatusURL = URL(string: CodeHelper.APIBaseUrl+"change/\(CurrentOrdersResponse.getOrderNumber())/status")!
      
    func changeOrderStatus(status:String,cancelReson:String,completion: @escaping (String?, _ order:NewOrderDetailsResponse?) -> Void) {
          let headers : HTTPHeaders = ["Content-Type": "application/json",
                                       "Accept": "application/json",
                                       "Authorization": "Bearer "+CodeHelper.getCurrentUserToken()]
          print("dddd",CodeHelper.getCurrentUserToken())
        let parameters: [String: String] = [
            "status" : status,
            "cancelReson" : cancelReson
            
        ]

          AF.request(changeOrderStatusURL, method: .post, parameters: parameters, encoding : JSONEncoding.default, headers: headers).responseJSON { (response) in
              print("url \(self.changeOrderStatusURL)")
              if response.response?.statusCode == 200{
                  print(response)
              }
              switch response.result{
              case .failure:
                  print("faild")
                completion("errrrrrorrr",nil)
              case .success:
                  
                  let json = JSON(response.value!)
                  print(json)
                  let orderNo = json["data"]["orderNo"].intValue
                  let name = json["data"]["name"].stringValue
                  let phone = json["data"]["phone"].stringValue
                  let address = json["data"]["address"].stringValue
                  let price = json["data"]["price"].stringValue
                  let clientName = json["data"]["clientName"].stringValue
                  let status = json["data"]["status"].stringValue
                  let startedAtTime = json["data"]["startedAt"].stringValue
                  let receivedAtTime = json["data"]["receivedAt"].stringValue
                  let finishedAtTime = json["data"]["finishedAt"].stringValue
                  let time = json["data"]["time"].stringValue
                  
                  let orderDetails = NewOrderDetailsResponse(orderNo: orderNo, name: name, phone: phone, address:address , price: price, clientName:clientName , status:status , receivedAtTime: receivedAtTime, startedAtTime:startedAtTime , finishedAtTime: finishedAtTime, time: time)
                  
                  completion(nil,orderDetails)
                  print(orderDetails)
              }
              
              
          }
      }
}
