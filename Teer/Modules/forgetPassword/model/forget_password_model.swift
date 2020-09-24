//
//  forget_password_model.swift
//  Teer
//
//  Created by Boo Doo on 9/13/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class forget_password_model {
    let forget_password_url = URL(string: CodeHelper.APIBaseUrl+"password/forgot")!
    let verifiy_url = URL(string: CodeHelper.APIBaseUrl+"password/reset")!
//    var model: vifiry_code?
    func forget_password(phone: String, closure: @escaping (_ obj: vifiry_code?) -> Void) {
           let parameters: [String: Any] = [
               "phone" : phone
           ]
        Indicator.sharedInstance.showIndicator()

           AF.request(forget_password_url, method: .post, parameters: parameters)
               .responseJSON { response in
                Indicator.sharedInstance.hideIndicator()

                guard response.data != nil else { return }
                   do {
                    let json = JSONDecoder()
                    let model = try json.decode(vifiry_code.self, from: response.data!)
                    closure(model)

                   } catch (let error) {
                       closure(nil)
                    print("error\(error.localizedDescription)")

                   }
           }
           
       }
    
    func verifiy(phone: String, password: String, confirmed_password: String, closure: @escaping (_ obj: reset_password?) -> Void) {
        let parameters: [String: Any] = [
            "phone" : phone,
            "password" : password,
            "password_confirmation": confirmed_password
        ]
     print("uri\(verifiy_url)")
     Indicator.sharedInstance.showIndicator()

        AF.request(verifiy_url, method: .post, parameters: parameters)
            .responseJSON { response in
                print("response\(response)")
             guard response.data != nil else { return }
                do {
                    print("inside do")
                 let json = JSONDecoder()
                 let model = try json.decode(reset_password.self, from: response.data!)
                 closure(model)

                } catch (let error) {
                    closure(nil)
                 print("error\(error.localizedDescription)")

                }
        }
        
    }
}
