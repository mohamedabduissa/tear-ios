//
//  LoginModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/23/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginModel {
    let loginUrl = URL(string: CodeHelper.APIBaseUrl+"login")!
    
    func login(phone: String, password: String, closure: @escaping (_ obj: Data?) -> Void) {
           let parameters: [String: Any] = [
               "phone" : phone,
               "password" : password
           ]
           AF.request(loginUrl, method: .post, parameters: parameters)
               .responseJSON { response in
                   print(response)
                guard response.data != nil else { return }
                   do {
                    let json = JSON(response.value!)
                    print(json)
                    let name = json["data"]["name"].stringValue
                    let phone = json["data"]["phone"].stringValue
                    let key = json["data"]["key"].intValue
                    let email = json["data"]["email"].stringValue
                    let apiToken = json["api_token"].stringValue
    
                    let user = Data(key: key, name: name, email: email, phone: phone, apiToken: apiToken)

                    CodeHelper.saveCurrentUserToken(userToken: (user.apiToken)!)

                    closure(user)
                   } catch _ {
                       closure(nil)

                   }
           }
           
       }

}
