//
//  DeliveryStatusModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/25/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class DeliveryStatusModel {
    let orderCountableByStatusUrl = URL(string: CodeHelper.APIBaseUrl+"total/orders/countable")!
    
 
        func orderCountableByStatus(completion: @escaping (String?, _ order:DeliveryStatusResponse?) -> Void) {
            let headers : HTTPHeaders = ["Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())"]
            print("dddd",CodeHelper.getCurrentUserToken())
            AF.request(orderCountableByStatusUrl, method: .get, parameters: nil, encoding : JSONEncoding.default, headers: headers).responseJSON { (response) in
        
                if response.response?.statusCode == 200{
                print(response)
                }
                switch response.result{
                case .failure:
                    print("faild")
                case .success:
                    
                    let json = JSON(response.value!)
                    print(json)
                let new = json["data"]["new"].intValue
                let cancel = json["data"]["cancel"].intValue
                let complete = json["data"]["complete"].intValue
                let processing = json["data"]["processing"].intValue
                
                
                let order = DeliveryStatusResponse(new: new, cancel: cancel, complete: complete, processing: processing)
                
                    completion(nil,order)
                print(order)
            }
            
        
        }
    }
    
    
}
