//
//  TermsAndConditionsModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/16/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class TermsAndConditionsModel {
    let termsAndConditionsURL = URL(string: CodeHelper.APIBaseUrl+"general/terms")!
       
       func termsAndConditions(completion: @escaping (String?, _ data:String?) -> Void) {
           let headers : HTTPHeaders = ["Content-Type": "application/json",
                                        "Accept": "application/json",
                                        "Authorization": "Bearer "+CodeHelper.getCurrentUserToken()]
           print("dddd",CodeHelper.getCurrentUserToken())
           AF.request(termsAndConditionsURL, method: .get, parameters: nil, encoding : JSONEncoding.default, headers: headers).responseJSON { (response) in
               print("url \(self.termsAndConditionsURL)")
               if response.response?.statusCode == 200{
                   print(response)
               }
               switch response.result{
               case .failure:
                   print("faild")
               case .success:
                   
                   let json = JSON(response.value!)
                   print(json)
                   let data = json["data"].stringValue
                 
                   
                  
                   
                   completion(nil,data)
               }
               
               
           }
       }
}
