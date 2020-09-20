//
//  NotificationsModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/10/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import MOLH
//import SwiftyJSON

protocol DRHTableviewDataModelDelegate:class{
    func didRecieveNotificationsDataUpdate(data: [NotificationsData])
    func didFailDataUpdateWithError(error: Error)
    func startLoading()
    func stopLoading()
}
class NotificationsModel: NSObject {
    weak var delegate:DRHTableviewDataModelDelegate?
    
    let notificationsURL = URL(string: CodeHelper.APIBaseUrl+"notifications")!
    func getNotifications() {
        var data: [AnyObject]? = nil
        let error: Error? = nil
        let language = MOLHLanguage.currentAppleLanguage()
        let headers : HTTPHeaders = ["Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())", "Accept-Language":"\(language)"]
        delegate?.startLoading()
        
        AF.request(notificationsURL, method: .get, encoding : URLEncoding.default, headers:headers).responseJSON { (response) in
            
            let dic:NSDictionary = response.value as! NSDictionary
                       data = dic.value(forKey: "data") as? [AnyObject]
                      
                       if let error = error {
                           self.delegate?.stopLoading()
                           self.delegate?.didFailDataUpdateWithError(error: error)
                           
                       } else if let data = data {
                           self.delegate?.stopLoading()
                           self.setDataWithResponse(response: data)
                       }
        }
    }
    private func setDataWithResponse(response: [AnyObject]) {
           var data = [NotificationsData]()
           for item in response {
               let NotificationsDic:NSDictionary = item as! NSDictionary
               
               print(NotificationsDic)
               if let drhTableViewDataModelItem = NotificationsData(data:NotificationsDic) {
                   data.append(drhTableViewDataModelItem)
               }
           }
           delegate?.didRecieveNotificationsDataUpdate(data: data)
       }
}
