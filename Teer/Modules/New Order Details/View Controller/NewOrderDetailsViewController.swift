//
//  NewOrderDetailsViewController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/5/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH
class NewOrderDetailsViewController: UIViewController,NewOrderDetailsProtocol,ChangeOrderStatusProtocol {
   
    
    func changeOrderStatusSuccess() {
        presenter.getNewOrderDetails()
        changeStatusDetails(status: status!)
    }
 
    
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var clientAddressLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var receviedTimeLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var newOrderDeliveryTimeView: UIView!
    @IBOutlet weak var startJourneyTimeLabel: UILabel!
    @IBOutlet weak var orderDeliverdTimeLabel: UILabel!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var deliveryOwnerDetailsView: UIView!
    @IBOutlet weak var orderReceviedGrayView: UIView!
    @IBOutlet weak var orderReceviedGreenMarkImageView: UIImageView!
    @IBOutlet weak var startJourneyGreenMarkImageView: UIImageView!
    @IBOutlet weak var startJourneyGrayView: UIView!
    @IBOutlet weak var orderDeliverdGreenMarkImageView: UIImageView!
    @IBOutlet weak var orderDeliverdGrayView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var callViewWidthConstrain: NSLayoutConstraint!
    @IBOutlet weak var changeOrderStatusBtn: CustomBtn!
    @IBOutlet weak var deliveredOrderTitelLabel: UILabel!
    @IBOutlet weak var deliveredOrderDescription: UILabel!
    
    let presenter = NewOrderDetailsPresenter(newOrderDetailsModel: NewOrderDetailsModel())
    
    let changeOrderStatusPresenter = ChangeOrderStatusPresenter(changeOrderStatusModel: ChangeOrderStatusModel())
    let toastMessage = ToastMessages()
    var status : String?
    var clientPhoneNumber : String?
    var view_type = ""
    @IBOutlet weak var newOrderDeliveryViewHeightConstrain: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        orderReceviedGrayView.isHidden = true
        orderReceviedGreenMarkImageView.isHidden = false
        changeOrderStatusPresenter.setVCDelegate(vcDelegate: self)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.callBtnDidTapped (_:)))
        callView.addGestureRecognizer(gesture)

        newOrderDeliveryViewHeightConstrain.constant = newOrderDeliveryTimeView.frame.width
        newOrderDeliveryTimeView.circular()
        
        newOrderDeliveryTimeView.layer.borderColor = UIColor.white.cgColor
        newOrderDeliveryTimeView.layer.borderWidth = 5.0
        
        
        callView.layer.borderColor = UIColor.white.cgColor
        callView.layer.borderWidth = 5.0
        callView.circular()
        
        deliveryOwnerDetailsView.layer.cornerRadius = deliveryOwnerDetailsView.frame.height / 1.8
        
        startJourneyGrayView.circular()
        orderDeliverdGrayView.circular()
        orderReceviedGrayView.circular()
        
        if  MOLHLanguage.isArabic(){
               self.backButton.transform = self.backButton.transform.rotated(by: CGFloat(Double.pi))
        }
        presenter.setVCDelegate(vcDelegate: self)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getNewOrderDetails()
    }
    func showError(msg: String) {
        toastMessage.createToastMessage(msg)

    }
     
    func showAlert(msg: String) {
        toastMessage.createToastMessage(msg)

    }

    

      @objc func callBtnDidTapped(_ sender:UITapGestureRecognizer){
        if let  number = clientPhoneNumber {
        guard let url = URL(string: "tel://\(number)") else {
        return //be safe
        }
        


        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        }
      }
    func displayOrderData(_ order: (orderNo: Int, name: String, phone: String, address: String, price: String, clientName: String, status: String, receivedAtTime: String, startedAtTime: String, finishedAtTime: String, time: String)) {
        orderNumberLabel.text = "#" + String(order.orderNo)
        receviedTimeLabel.text = order.receivedAtTime
        orderDeliverdTimeLabel.text = order.finishedAtTime
        startJourneyTimeLabel.text = order.startedAtTime
        deliveryTimeLabel.text = order.startedAtTime
        clientAddressLabel.text = order.address
        clientNameLabel.text = order.name
        orderPriceLabel.text = order.price + " SAR".localize
        status = order.status
        clientPhoneNumber = order.phone
        changeStatusDetails(status: status!)
        
        
    }
    @IBAction func backBtnDidTapped(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//        print("view_type\(view_type)")
        if view_type == "table_view"{
            let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
                self.present(view, animated: true, completion: nil)
        }
        else if view_type == "collection_view"{
            let view = UIStoryboard(name: "OrdersHistory", bundle: nil).instantiateViewController(withIdentifier: "OrdersHistoryVC") as! DeliveryStatusViewController
            self.present(view, animated: true, completion: nil)
        }

       
    }
    
    @IBAction func informationBtnDidTapped(_ sender: Any) {
        let view = UIStoryboard(name: "NewOrderDetails", bundle: nil).instantiateViewController(withIdentifier: "RetrieveingOrderViewController") as! RetrieveingOrderViewController
        view.status = "cancel"
        self.present(view, animated: true, completion: nil)
        
    }
    func changeStatusDetails(status:String)
    {
        switch status {
        case "new":
            changeOrderStatusBtn.setTitle("accept order".localize, for: .normal)
 
        case "accept":
            changeOrderStatusBtn.setTitle("Start Journey".localize, for: .normal)
//            startJourneyGreenMarkImageView.isHidden  = false
//            startJourneyGrayView.isHidden = true
        case "processing":
//
            startJourneyGrayView.isHidden = true
            startJourneyGreenMarkImageView.isHidden  = false
//            startJourneyGrayView.isHidden = true changeOrderStatusBtn.setTitle("complete".localize, for: .normal)
            changeOrderStatusBtn.setTitle("order Deliverd".localize, for: .normal)
   orderReceviedGrayView.isHidden = true
              orderReceviedGreenMarkImageView.isHidden = false

            orderReceviedGrayView.isHidden = true
            orderReceviedGreenMarkImageView.isHidden = false
            informationButton.isEnabled = false
        case "complete":
        changeOrderStatusBtn.setTitle("order Deliverd".localize, for: .normal)
        startJourneyGreenMarkImageView.isHidden  = false
        startJourneyGrayView.isHidden = true
            orderDeliverdGreenMarkImageView.isHidden = false
            orderDeliverdGrayView.isHidden = true
            orderReceviedGrayView.isHidden = true
            startJourneyGrayView.isHidden = true
            changeOrderStatusBtn.isEnabled = false
            
            orderDeliverdGreenMarkImageView.isHidden = false
            orderReceviedGreenMarkImageView.isHidden = false
            startJourneyGreenMarkImageView.isHidden = false
            informationButton.isEnabled = false

        case "cancel":
            changeOrderStatusBtn.setTitle("cancel".localize, for: .normal)

            deliveredOrderTitelLabel.text = "canceled".localize
            deliveredOrderDescription.text = "Order had been canceled from customer".localize
            changeOrderStatusBtn.isEnabled = false
            orderDeliverdGreenMarkImageView.isHidden = false
            orderReceviedGreenMarkImageView.isHidden = false
            startJourneyGreenMarkImageView.isHidden = false
            informationButton.isEnabled = false

        default:break
        }
    }
    @IBAction func changeOrderStatusBtnDidTapped(_ sender: Any) {
        switch status {
        case "new":
            changeOrderStatusPresenter.changeOrderStatus(status: "accept", caneclReson: "")
                       // changeOrderStatusBtn.setTitle("Start Journey".localize, for: .normal)

            informationButton.isEnabled = false
        case "accept":
            changeOrderStatusPresenter.changeOrderStatus(status: "processing", caneclReson: "")

        case "processing":
            informationButton.isEnabled = false
            let alert = AlertController(title: "", message: "".localize, preferredStyle: .alert)
            
            alert.setTitleImage(UIImage(named: "sun"))
            let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.red]
            let messageString = NSAttributedString(string: "order_complete".localize, attributes: messageAttributes)
            alert.setValue(messageString, forKey: "attributedMessage")
            
           
            let delvierd = UIAlertAction(title: "order Deliverd".localize, style: .default) { (action) in
                print("deliverd")
                let view = UIStoryboard(name: "NewOrderDetails", bundle: nil).instantiateViewController(withIdentifier: "RetrieveingOrderViewController") as! RetrieveingOrderViewController
                view.status = "complete"
                self.present(view, animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: "retrieved".localize, style: .default) { (action) in
                print("cancel")
                let view = UIStoryboard(name: "NewOrderDetails", bundle: nil).instantiateViewController(withIdentifier: "RetrieveingOrderViewController") as! RetrieveingOrderViewController
                view.status = "cancel"
                self.present(view, animated: true, completion: nil)
            }
             cancel.setValue(UIColor(red: 0.82, green: 0.25, blue: 0.36, alpha: 1.00)
            , forKey: "titleTextColor")

            delvierd.setValue(UIColor(red: 0.82, green: 0.25, blue: 0.36, alpha: 1.00)
            , forKey: "titleTextColor")
            alert.addAction(delvierd)
            alert.addAction(cancel)
            present(alert,animated: true,completion: nil)
//            changeOrderStatusPresenter.changeOrderStatus(status: "complete", caneclReson: "")
       

        default:
            break
        }

      //  changeStatusDetails(status: status!)
        
    }
    
    
   
}
