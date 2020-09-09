//
//  ProfileModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/16/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProfileModel {
    let profileUrl = URL(string: CodeHelper.APIBaseUrl+"profile/update")!
    
    func profileUpdate(name: String, email: String, phone: String, closure: @escaping (_ obj: ProfileResponse?) -> Void) {
        let headers : HTTPHeaders = ["Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())"]
           let parameters: [String: Any] = [
               "name" : name,
               "email" : email,
               "phone" : phone
           ]
           AF.request(profileUrl, method: .post, parameters: parameters, encoding : JSONEncoding.default, headers: headers)
               .responseJSON { response in
                   print(response)
                guard response.data != nil else { return }
                   do {
                    let json = JSON(response.value!)
                    print(json)
                    let name = json["data"]["name"].stringValue
                    let email = json["data"]["email"].stringValue
                    //let phone = json["data"]["phone"].stringValue
    
                    let profile = ProfileResponse(name: name, email: email, phone: phone)
                    //CodeHelper.saveCurrentUserToken(userToken: (user.apiToken)!)

                    closure(profile)
                   } catch _ {
                       closure(nil)

                   }
           }
           
       }

}
