//
//  NotificationsTableVC.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/10/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH

class NotificationsTableVC: UIViewController {

    // The two object use to show the spinner loading
    var loadingView: UIView = UIView()
    var spinner = UIActivityIndicatorView(style: .whiteLarge)

    var notifications = NSArray()
    

    @IBOutlet weak var backBtnImage: UIButton!
    @IBOutlet weak var notificationsTable: UITableView!
    
//    let notificatiosPresenter = NotificationsPresenter(notificationsModel: NotificationsModel())
    private let dataSource = NotificationsModel()
    
    let toastMessage = ToastMessages()
    
    fileprivate var dataArray = [NotificationsData]() {
           didSet {
               notificationsTable?.reloadData()
               notificationsTable.setNeedsDisplay()
               self.view.setNeedsDisplay()
               self.view.layoutIfNeeded()
               
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationsTable.rowHeight = 120.0
        dataSource.delegate = self as! DRHTableviewDataModelDelegate
        dataSource.getNotifications()

        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            //self.hideActivityIndicator()
          //  self.displayNotificationsData()
            print("2111212")
        }
        
        if  MOLHLanguage.isArabic(){
               self.backBtnImage.transform = self.backBtnImage.transform.rotated(by: CGFloat(Double.pi))
        }
        
       // displayNotificationsData()
    }
    
    
    @IBAction func onBackBtnTapped(_ sender: Any) {
        let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
        self.present(view, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
     //   notificatiosPresenter.getNotifications()
       // displayNotificationsData()
        self.notificationsTable.reloadData()
    }
    
}
extension NotificationsTableVC : UITableViewDataSource{
    func showAlert(msg: String) {
        toastMessage.createToastMessage(msg)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as? NotificationsCell
        let Data = dataArray[indexPath.item]
        
        cell?.cellTitle.text = Data.title
        cell?.cellBody.text = Data.body
        cell?.cellDate.text = Data.date
        return cell!
    }

    
    //MARK:- Show empty message if table is empty
     func numberOfSections(in tableView: UITableView) -> Int {
        if dataArray.count > 0 {
            hideTableEmptyMessage()
            return 1
        } else {
            showTableEmptyMessage(message: "You don't have any Notifications yet.")
            return 0
        }
    }
    
    // MARK: - Table Animation
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let reotate = CATransform3DTranslate(CATransform3DIdentity, 0,40, 0)
        cell.layer.transform = reotate
        cell.alpha = 0
        //cell.accessoryView = UIImageView(image: UIImage(named: "5.png"))
        UIView.animate(withDuration: 0.9){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    //MARK: - Private Functions
    
    func showTableEmptyMessage(message:String) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 16)
        messageLabel.sizeToFit()
        
        notificationsTable.backgroundView = messageLabel
        notificationsTable.separatorStyle = .none
    }
    
    func hideTableEmptyMessage() {
        notificationsTable.backgroundView = nil
        //notificationsTable.separatorStyle = .singleLine
    }
    
    //Those two method serves to show a spinner when the request is in execution

    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor(hex: "#111111")
            self.loadingView.alpha = 0.9
            self.loadingView.clipsToBounds = true
            self.spinner = UIActivityIndicatorView(style: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }

}
extension NotificationsTableVC:DRHTableviewDataModelDelegate{
    func didRecieveNotificationsDataUpdate(data: [NotificationsData]) {
        //DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.dataArray = data
       // }
    }
    
    func didFailDataUpdateWithError(error: Error) {
        
    }
    
    func startLoading() {
        print("start")
    //    SVProgressHUD.show()
    }
    func stopLoading() {
        print("stop")
     //   SVProgressHUD.dismiss()
    }
}

