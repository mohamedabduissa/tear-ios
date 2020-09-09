//
//  NotificationsPresenter.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/10/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
class NotificationsPresenter {
    
    let notificationsModel: NotificationsModel
    var notificationsDelegate: NotificationsProtocol?
    var notificationsList : [NotificationsData]
    let toast = ToastMessages()
    init(notificationsModel: NotificationsModel) {
        self.notificationsModel = notificationsModel
        notificationsList = [NotificationsData]()
    }
    
    func setVCDelegate(vcDelegate: NotificationsProtocol?) {
        self.notificationsDelegate = vcDelegate
    }
    
    //    func getNotifications() {
    //        self.notificationsModel.getNotifications(completion: {error , notificationsDataList in
    //            print("sdsdsdsdsdsd-----------")
    //            if notificationsDataList != nil {
    //
    //                self.notificationsList = notificationsDataList!
    //                self.notificationsDelegate?.displayNotificationsData()
    //                print(self.notificationsList[0])
    //            }
    //            else{
    //                self.notificationsDelegate?.showAlert(msg: "Something went wrong")
    //            }
    //
    //        })
    //
    //    }
    //
    func getNotificationsCount()-> Int
    {
        return notificationsList.count
    }
}

protocol NotificationsProtocol: NSObjectProtocol {
    func showAlert(msg: String)
    func displayNotificationsData()
}
