//
//  rechability.swift
//  Teer
//
//  Created by Boo Doo on 9/29/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Reachability
class ConnectionManager {
    static let sharedInstance = ConnectionManager()
    private var reachability : Reachability?
//    private var isScreenPresented = false
    let toastMessage = ToastMessages()

    init() {
        self.reachability = try? Reachability()
//        toastMessage.createToastMessage("no internert")
    }
    func observeReachability() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability?.startNotifier()
        }
        catch(_) {
            debugPrint("error in boserving network status ")
        }
    }
    func stopObserveReachability() {
        self.reachability?.stopNotifier()
    }
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular, .wifi :
//            toastMessage.createToastMessage("internert")


            break
        case .none, .unavailable:
            toastMessage.createToastMessage("\("no_internet".localize)")

            
        }
    }
}
