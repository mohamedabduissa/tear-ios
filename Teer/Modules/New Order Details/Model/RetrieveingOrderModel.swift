//
//  RetrieveingOrderModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/15/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class RetrieveingOrderModel{
    let retrieveingOrderURL =  URL(string: CodeHelper.APIBaseUrl+"change/\(CurrentOrdersResponse.getOrderNumber())/status")!
         
    func submitRetrieveingOrderReason(retrieveingReason:String, status: String,completion: @escaping (String?) -> Void) {
             let headers : HTTPHeaders = ["Content-Type": "application/json",
                                          "Accept": "application/json",
                                          "Authorization": "Bearer "+CodeHelper.getCurrentUserToken()]
             print("dddd",CodeHelper.getCurrentUserToken())
        print("getOreder\(CurrentOrdersResponse.getOrderNumber())")
        print("dddddddd\(CurrentOrdersResponse.getOrderNumber())")
           let parameters: [String: String] = [
               "status" : "\(status)",
               "cancelReson" : retrieveingReason
               
           ]
        Indicator.sharedInstance.showIndicator()

             AF.request(retrieveingOrderURL, method: .post, parameters: parameters, encoding : JSONEncoding.default, headers: headers).responseJSON { (response) in
                 print("url \(self.retrieveingOrderURL)")
                Indicator.sharedInstance.hideIndicator()

                 if response.response?.statusCode == 200{
                     print("response \(response)")
                 }
                 switch response.result{
                 case .failure:
                     print("faild")
                   completion("errrrrrorrr")
                 case .success:
                     
                     let json = JSON(response.value!)
                     print(json)
                     let status = json["messaage"].stringValue
                     completion(nil)
                     print(status)
                 }
                 
                 
             }
         }
}
