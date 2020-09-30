//
//  DeliveryStatusViewController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/25/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH

class DeliveryStatusViewController: UIViewController, DeliveryStatusProtocol, OrdersHistoryProtocol {
    
    
    var x: String = ""
    var prossing = false
    var complete_orders = false
    let orderNumber = NewOrderDetailsResponse.self
    @IBOutlet weak var currentOrdersTableView: UITableView?
    
    @IBOutlet weak var ttt: UILabel!
    
    
    @IBOutlet weak var sss: UIImageView!
    
    @IBOutlet weak var orderHistoryBackBtn: UIButton!
    @IBOutlet weak var ordersHistorySelectDate: UIButton!
    @IBOutlet weak var orderHistoryDate: UILabel!
    
    @IBOutlet weak var totalOrdersHistory: UILabel!
    
    @IBOutlet weak var total_img: UIImageView?
    
    
    @IBOutlet weak var new: UILabel?
    @IBOutlet weak var processing: UILabel!
    @IBOutlet weak var complete: UILabel!
    @IBOutlet weak var cancel: UILabel!
    
    
    
    @IBOutlet weak var underway: UIImageView!
    
    
    
    @IBOutlet weak var delivered: UIImageView!
    
    
    @IBOutlet weak var reterive: UIImageView!
    
    
    @IBOutlet weak var total: UIImageView!
    
    
    @IBOutlet weak var processingImg: UIImageView!
    
    @IBOutlet weak var newImg: UIImageView!
    
    @IBOutlet weak var cancelImg: UIImageView!
    @IBOutlet weak var completeImg: UIImageView!
    //MARK:- OrdersHistory Outlets
    @IBOutlet weak var ordersHistoryCollectionview: UICollectionView!
    
    
    
    
    var orders = [OrdersData]()
    

    let presenter = DeliveryStatusPresenter(deliveryModel: DeliveryStatusModel())
    let currentOrdersPresenter = CurrentOrdersPresenter(currnetOrdersModel: CurrentOrdersModel())
    let ordersHistoryPresenter = OrdersHistoryPresenter(ordersHistoryModel: OrdersHistoryModel())
    var histor: OrdersHistoryPresenter?
    let toastMessage = ToastMessages()
    var tapGestureRecognizer: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        if prossing == true{
//            underway.isFirstResponder = true
            
        }
        currentOrdersTableView?.rowHeight = 120
        if restorationIdentifier == "2"{
        ordersHistoryCollectionview?.delegate = self
        ordersHistoryCollectionview?.dataSource = self
            if  MOLHLanguage.isArabic(){
                self.orderHistoryBackBtn.transform = self.orderHistoryBackBtn.transform.rotated(by: CGFloat(Double.pi))
            }
            
        }
        
       
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.setVCDelegate(vcDelegate: self)
        currentOrdersPresenter.setVCDelegate(vcDelegate: self)        
        presenter.orderCountableByStatus()
        currentOrdersPresenter.getCurrentOrders()
        if restorationIdentifier == "2"{
            formatter.dateFormat = "dd-MM-yyyy"
            let result = formatter.string(from: date)
            print("res\(result)")
            orderHistoryDate.text = result
        ordersHistoryPresenter.setVCDelegate(vcDelegate: self)
            if prossing == true {
                ordersHistoryPresenter.getAllOrdersHistoryBYStatus(status: "processing")
                ordersHistoryCollectionview.reloadData()
            }
            else if complete_orders == true{
                ordersHistoryPresenter.getAllOrdersHistoryBYStatus(status: "complete")
                ordersHistoryCollectionview.reloadData()
            }
            else{
            ordersHistoryPresenter.getAllOrdersHistoryBYStatus(status: "total")
        ordersHistoryCollectionview?.reloadData()
        }
            set_tap_gesture()

        }
       
    }
    func set_tap_gesture()
    {
//        total.contentMode = UIView.ContentMode.scaleAspectFill
//              total.clipsToBounds = true
        let cancel_tap = UITapGestureRecognizer(target: self, action: #selector(self.cancel_order))
            reterive.addGestureRecognizer(cancel_tap)
        
        let complete_tap = UITapGestureRecognizer(target: self, action: #selector(self.complete_order))
        delivered.addGestureRecognizer(complete_tap)
        let total_tap = UITapGestureRecognizer(target: self, action: #selector(self.total_order))
        total.addGestureRecognizer(total_tap)
        let processing_tap = UITapGestureRecognizer(target: self, action: #selector(self.processing_order))
        underway.addGestureRecognizer(processing_tap)
        
    }
    
    
    @objc func cancel_order() {
        ordersHistoryPresenter.getAllOrdersHistoryBYStatus(status: "cancel")
        ordersHistoryCollectionview.reloadData()
        
        
    }
    
    @objc func processing_order() {
        ordersHistoryPresenter.getAllOrdersHistoryBYStatus(status: "processing")
        ordersHistoryCollectionview.reloadData()

        
    }
    @objc func complete_order() {
        ordersHistoryPresenter.getAllOrdersHistoryBYStatus(status: "complete")

        ordersHistoryCollectionview.reloadData()
        
    }
    @objc func total_order() {
        ordersHistoryPresenter.getAllOrdersHistoryBYStatus(status: "total")
       ordersHistoryCollectionview.reloadData()

        
    }
    func displayOrderData(_ order: (new: Int, complete: Int, processing: Int, cancel: Int)) {
        new?.text = "\(order.new)"
        cancel.text = "\(order.complete)"
        complete.text = "\(order.processing)"
        processing?.text = "\(order.cancel)"
        totalOrdersHistory?.text = "\(order.complete+order.processing+order.cancel)"
    }
    
    func showAlert(msg: String) {
        toastMessage.createToastMessage(msg)
    }
    
    //MARK:- Side Menu Btn
    @IBAction func onSideMenuBtnTapped(_ sender: Any) {
        goToMenuScreen()
    }
    //MARK:- Notification Btn
    @IBAction func onNotificationBtnTapped(_ sender: Any) {
        let view = UIStoryboard(name: "Notifications", bundle: nil).instantiateViewController(withIdentifier: "Notifications") as! NotificationsTableVC
            self.present(view, animated: true, completion: nil)
    }
    
    
    @IBAction func orderHistorySelectDate(_ sender: Any) {
        let view = UIStoryboard(name: "OrdersHistory", bundle: nil).instantiateViewController(withIdentifier: "SelectDateVC") as! SelectDateVC
               
        self.present(view, animated: true, completion: nil)
    }
    @IBAction func onOrderHistoryBackBtnTapped(_ sender: Any) {
        goToMenuScreen()
//        let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
//        self.present(view, animated: true, completion: nil)
        
//        dismiss(animated: true, completion: nil)

    }
    func goToMenuScreen() {
        let view = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenu") as! SideMenuTableViewController
            self.present(view, animated: true, completion: nil)
        }
    //MARK:- Date for Orders History
    let date = Date()
    let formatter = DateFormatter()
}
extension DeliveryStatusViewController : UITableViewDelegate,UITableViewDataSource,CurrentOrdersProtocol{
    func showError(msg: String) {
        currentOrdersTableView?.isHidden = true
    }
    
    func getCurrentOrdersSucces() {
        currentOrdersTableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! OrdersCell?
//               let value = cell?.orderNumber.text
//               NewOrderDetailsResponse.orderNum = value!
        let value = currentOrdersPresenter.request_number(for: indexPath.row)
        print("currnetOrder\(value)")
        CurrentOrdersResponse.save(value)
        let view = UIStoryboard(name: "NewOrderDetails", bundle: nil).instantiateViewController(withIdentifier: "NewOrderDetailsViewController") as! NewOrderDetailsViewController
        view.view_type = "table_view"
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
             self.present(view, animated: true, completion: nil)
        }
           
          
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentOrdersPresenter.getCurrentOrdersCount()
//        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath) as! OrdersCell
        currentOrdersPresenter.configure(cell: cell, for: indexPath.row)
        x = String(cell.orderNumber.text!)
        return cell
    }
    
    
}

extension DeliveryStatusViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func getOrdersHistorySucces() {
        if restorationIdentifier == "2"{
        ordersHistoryCollectionview.reloadData()
    }
    }
   
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("/////////////",ordersHistoryPresenter.getAllOrdersHistoryCount())
        return ordersHistoryPresenter.getAllOrdersHistoryCount()
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrdersHistoryCell", for: indexPath) as! OrdersHistoryCollectionViewCell
        
        ordersHistoryPresenter.configure(cell: cell, for: indexPath.row)
//        print("cell\(cell.orderNumber.text)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrdersHistoryCell", for: indexPath) as! OrdersHistoryCollectionViewCell
        
        let value = ordersHistoryPresenter.return_number(cell: cell, for: indexPath.row)
        print("collectionCell\(value)")
        
        let view = UIStoryboard(name: "NewOrderDetails", bundle: nil).instantiateViewController(withIdentifier: "NewOrderDetailsViewController") as! NewOrderDetailsViewController
        view.view_type = "collection_view"
        self.present(view, animated: true, completion: nil)

    }
    
    // open news article url
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        var articleUrl = URL(string: articles[indexPath.row].url)
//        if let articleUrl = articleUrl {
//            openUrl(articleUrl)
//        } else {
//            articleUrl = URL(string: articles[indexPath.row].url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//            guard let articleUrl = articleUrl else { return }
//            openUrl(articleUrl)
//        }
//    }
    
    
}
