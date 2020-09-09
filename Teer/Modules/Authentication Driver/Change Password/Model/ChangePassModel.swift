//
//  ChangePassModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/30/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ChangePassModel {
    let changePassUrl = URL(string: CodeHelper.APIBaseUrl+"password/change")!
    
    func changePass(oldPassword: String, password: String,passwordConfirmation: String, closure: @escaping (_ obj: ChangePassResposne?) -> Void) {
        let headers : HTTPHeaders = ["Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())"]
           let parameters: [String: Any] = [
               "oldpassword" : oldPassword,
               "password" : password,
               "password_confirmation" : passwordConfirmation
           ]
           AF.request(changePassUrl, method: .post, parameters: parameters, encoding : JSONEncoding.default, headers: headers)
               .responseJSON { response in
                   print(response)
                guard response.data != nil else { return }
                   do {
                    let json = JSON(response.value!)
                    print(json)
                    let status = json["status"].intValue
                    let message = json["message"].stringValue
                    let errors = json["errors"].stringValue
    
                    let changePass = ChangePassResposne(status: status, message: message, errors: errors)

                    //CodeHelper.saveCurrentUserToken(userToken: (changePass.apiToken)!)

                    closure(changePass)
                   } catch _ {
                       closure(nil)

                   }
           }
           
       }

}
