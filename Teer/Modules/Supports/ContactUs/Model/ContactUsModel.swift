//
//  ContactUsModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/17/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ContactUsModel {
    let ContactUsUrl = URL(string: CodeHelper.APIBaseUrl+"support/post/message")!
    
    func contactUs(title: String, type: String, message: String, closure: @escaping (_ obj: ContactUsResponse?) -> Void) {
        let headers : HTTPHeaders = ["Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())"]
           let parameters: [String: Any] = [
               "title" : title,
               "type" : type,
               "message" : message
           ]
           AF.request(ContactUsUrl, method: .post, parameters: parameters, encoding : JSONEncoding.default, headers: headers)
               .responseJSON { response in
                   print(response)
                guard response.data != nil else { return }
                   do {
                    let json = JSON(response.value!)
                    print(json)
                    let status = json["status"].intValue
                    let message = json["message"].stringValue
    
                    let contact = ContactUsResponse(status: status, message: message)

                    closure(contact)
                   } catch _ {
                       closure(nil)

                   }
           }
           
       }

}
