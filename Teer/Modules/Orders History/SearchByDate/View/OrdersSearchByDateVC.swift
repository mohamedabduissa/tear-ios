//
//  OrdersSearchByDateVC.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/21/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH

class OrdersSearchByDateVC: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource, OrdersSearchProtocol{
    
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var orderSearchBackBtn: UIButton!
    @IBOutlet weak var noOrdersFoundView: UIView!
    @IBOutlet weak var searchOrdersCollectionView: UICollectionView!
    
    var orders = [OrdersData]()
    let ordersSearchPresenter = OrdersSearchPresenter(ordersSearchModel: OrdersSearchModel())
      let toastMessage = ToastMessages()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchOrdersCollectionView?.delegate = self
        searchOrdersCollectionView?.dataSource = self
            if  MOLHLanguage.isArabic(){
                self.orderSearchBackBtn.transform = self.orderSearchBackBtn.transform.rotated(by: CGFloat(Double.pi))
            
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedDate.text = CodeHelper.getSelectedDate()
        print(CodeHelper.getSelectedDate())
        ordersSearchPresenter.setVCDelegate(vcDelegate: self)
        ordersSearchPresenter.getAllOrdersSearch(date: CodeHelper.getSelectedDate())
        searchOrdersCollectionView?.reloadData()
        }
    
    
    @IBAction func onBackBtnTapped(_ sender: Any) {
        let view = UIStoryboard(name: "OrdersHistory", bundle: nil).instantiateViewController(withIdentifier: "OrdersHistoryVC") as! DeliveryStatusViewController
                             
                      self.present(view, animated: true, completion: nil)
    }
    
    func showAlert(msg: String) {
        toastMessage.createToastMessage(msg)
    }
    func showError(msg: String) {
        noOrdersFoundView?.isHidden = false
    }

func getOrdersSearchSucces() {
    noOrdersFoundView?.isHidden = true
    searchOrdersCollectionView.reloadData()
    }
   
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("getAllOrdersSearchCount",ordersSearchPresenter.getAllOrdersSearchCount())
        return ordersSearchPresenter.getAllOrdersSearchCount()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrdersHistoryCell", for: indexPath) as! OrdersHistoryCollectionViewCell
        ordersSearchPresenter.configure(cell: cell, for: indexPath.row)
        
        return cell
    }
}

