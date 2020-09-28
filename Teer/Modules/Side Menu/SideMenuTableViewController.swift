//
//  SideMenuTableViewController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/29/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import Foundation
import MOLH

class SideMenuTableViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var sideMenuTable: UITableView!
    
    let logout = Logout()
    var items = [SideItems]()
    fileprivate let cellIdentifier = "SideCell"
    fileprivate let cellHeight: CGFloat = 60.0
    fileprivate func prepareNavigationStyle() {
        UINavigationBar.appearance().tintColor = .white
        //UINavigationBar.appearance().barTintColor = .brown
        //UINavigationBar.appearance().isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationStyle()
        //sideMenuTable.backgroundColor = .clear
        sideMenuTable.separatorColor = .white
        //sideMenuTable.removeMargins()
        sideMenuTable.tableFooterView = UIView()
        sideMenuTable.dataSource = self
        sideMenuTable.delegate = self
//        sideMenuTable.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        items = SideItems.allItems()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sideMenuTable.reloadData()
    }
    
    // MARK: - Table view data source
    
        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SideMenuTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(item: items[indexPath.row])
        return cell
    }
    // MARK: - Table Animation
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let reotate = CATransform3DTranslate(CATransform3DIdentity, 0,40, 0)
        cell.layer.transform = reotate
        cell.alpha = 0
        cell.accessoryView = UIImageView(image: UIImage(named: "5.png"))
        //let accessory = cell.accessoryView
        if  MOLHLanguage.isArabic(){
            cell.accessoryView? = UIImageView(image: UIImage(named: "5.png")?.withHorizontallyFlippedOrientation())
        }
        UIView.animate(withDuration: 0.9){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

class SideItems{
    var type: SideType
    private var imageName: String
    
    var image: UIImage?{
        return UIImage.init(named: imageName)
    }
    
    var title: String {
        return type.localized
    }
    
    init(type: SideType, imageName: String) {
        self.type = type
        self.imageName = imageName
    }
    
    class func allItems() -> [SideItems] {
        let main = SideItems(type: .home, imageName: "menu-1")
        let search = SideItems(type: .orderHistory, imageName: "review")
        let myads = SideItems(type: .changeLanguage, imageName: "Global-Language")
        let profile = SideItems(type: .changePassword, imageName: "password")
        let logout = SideItems(type: .logout, imageName: "share_1_")
        let favourite = SideItems(type: .personalData, imageName: "user")
        let appTerms = SideItems(type: .termsOfService, imageName: "contract")
        let contactUs = SideItems(type: .contactUs, imageName: "ContactUs")
        let notifications = SideItems(type: .notifications, imageName: "bell")
        let processing = SideItems(type: .processing, imageName: "tracking")
        let delivered = SideItems(type: .delivered, imageName: "contract")
        return [main,notifications,processing , delivered,search, myads, favourite, profile, appTerms, contactUs, logout]
        
    }
}

enum SideType {
    case changeLanguage
    case changePassword
    case contactUs
    case logout
    case termsOfService
    case home
    case personalData
    case orderHistory
    case notifications
    case processing
    case delivered
    case about_app
    var localized: String {
        switch self {
        case .home:
            return "Main".localize
        case .personalData:
            return "Personal Data".localize
        case .changeLanguage:
            return "Change Language".localize
        case .changePassword:
            return "Change Password".localize
        case .termsOfService:
            return "Terms Of Service".localize
        case .contactUs:
            return "Contact Us".localize
        case .logout:
            return "Logout".localize
        case .orderHistory:
            return "Orders History".localize
        case .notifications:
            return "notifications".localize
        case .processing:
            return "processing".localize
        case .delivered:
            return "complete".localize
        case .about_app:
            return "about_app".localize
        }
    }
}
extension SideMenuTableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        switch item.type {
        case .home:
            handleHome()
        case .orderHistory:
            handleOrderHistory()
        case .personalData:
            handlePersonalData()
        case .termsOfService:
            handleTermsOfService()
        case .changeLanguage:
            handleChangeLanguage()
        case .changePassword:
            handleChangePassword()
        case .contactUs:
            handleContactUs()
        case .logout:
            handleLogout()
        case .notifications:
            handleNotification()
        case .processing:
            handle_underprocessing()
        case .delivered:
            handle_delivered()
        case .about_app:
            print("no thing to  show")
        }
        prepareNavigationStyle()
    }
    
    private func handleHome() {
       let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
        self.present(view, animated: true, completion: nil)
    }
    private func handle_bout_app() {
          let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
           self.present(view, animated: true, completion: nil)
       }
    private func handle_underprocessing() {
     let view = UIStoryboard(name: "OrdersHistory", bundle: nil).instantiateViewController(withIdentifier: "OrdersHistoryVC") as! DeliveryStatusViewController
        view.prossing = true
       self.present(view, animated: true, completion: nil)
    }
    private func handle_delivered() {
     let view = UIStoryboard(name: "OrdersHistory", bundle: nil).instantiateViewController(withIdentifier: "OrdersHistoryVC") as! DeliveryStatusViewController
        view.complete_orders = true
       self.present(view, animated: true, completion: nil)
    }
    private func handleOrderHistory() {
        let view = UIStoryboard(name: "OrdersHistory", bundle: nil).instantiateViewController(withIdentifier: "OrdersHistoryVC") as! DeliveryStatusViewController
        self.present(view, animated: true, completion: nil)
    }
    
    private func handlePersonalData() {
        let view = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        self.present(view, animated: true, completion: nil)
    }
    
    private func handleContactUs() {
        let view = UIStoryboard(name: "ContactUs", bundle: nil).instantiateViewController(withIdentifier: "ContactUs") as! ContactUsViewController
        self.present(view, animated: true, completion: nil)
    }
    private func handleNotification() {
            let view = UIStoryboard(name: "Notifications", bundle: nil).instantiateViewController(withIdentifier: "Notifications") as! NotificationsTableVC
                self.present(view, animated: true, completion: nil)
       }
    private func handleTermsOfService() {
        let view = UIStoryboard(name: "TermsAndConditions", bundle: nil).instantiateViewController(withIdentifier: "TermsAndConditions") as! TermsAndConditions
        self.present(view, animated: true, completion: nil)
    }
    
    private func handleChangeLanguage() {
        let view = UIStoryboard(name: "ChangeLanguage", bundle: nil).instantiateViewController(withIdentifier: "ChangeLanguageViewController") as! ChangeLanguageViewController
        self.present(view, animated: true, completion: nil)
    }
    
    private func handleChangePassword() {
        let view = UIStoryboard(name: "ChangePassword", bundle: nil).instantiateViewController(withIdentifier: "ChangePassword") as! ChangePasswordVC
        self.present(view, animated: true, completion: nil)
    }
    
    private func handleMyAccount() {
        let view = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenu") as! SideMenuTableViewController
        self.present(view, animated: true, completion: nil)
    }
    
    private func handleReceivedRequests() {
        let view = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenu") as! SideMenuTableViewController
        self.present(view, animated: true, completion: nil)
    }
    
    private func handleSentRequests() {
        let view = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenu") as! SideMenuTableViewController
        self.present(view, animated: true, completion: nil)
    }
    
    private func handleLogout() {
        logout.callLogoutAPI()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Login", bundle:nil)
           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginScreen") as! UIViewController
        //nextViewController.modalTransitionStyle = .flipHorizontal
           self.present(nextViewController, animated:true, completion:nil)
        print("logged out ......")
    }
    
    private func handleAppDescription() {
        let view = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenu") as! SideMenuTableViewController
        self.present(view, animated: true, completion: nil)
    }
}
