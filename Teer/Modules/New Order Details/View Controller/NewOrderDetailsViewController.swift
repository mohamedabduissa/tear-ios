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
    @IBOutlet weak var newOrderDeliveryViewHeightConstrain: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        changeOrderStatusPresenter.setVCDelegate(vcDelegate: self)
        self.backButton.transform = self.backButton.transform.rotated(by: CGFloat(Double.pi))
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
        guard let url = URL(string: "tel://\(clientPhoneNumber)"),
                 UIApplication.shared.canOpenURL(url) else { return }
             if #available(iOS 10, *) {
                 UIApplication.shared.open(url)
             } else {
                 UIApplication.shared.openURL(url)
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
        dismiss(animated: true, completion: nil)
//        let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
//               self.present(view, animated: true, completion: nil)
    }
    
    @IBAction func informationBtnDidTapped(_ sender: Any) {
        let view = UIStoryboard(name: "NewOrderDetails", bundle: nil).instantiateViewController(withIdentifier: "RetrieveingOrderViewController") as! RetrieveingOrderViewController
               
        self.present(view, animated: true, completion: nil)
        
    }
    func changeStatusDetails(status:String)
    {
        switch status {
        case "new":
           
            changeOrderStatusBtn.setTitle("Start Journey".localize, for: .normal)
            orderReceviedGrayView.isHidden = true
            orderReceviedGreenMarkImageView.isHidden = false
        case "processing":
          
            changeOrderStatusBtn.setTitle("order Deliverd".localize, for: .normal)
            startJourneyGreenMarkImageView.isHidden  = false
            startJourneyGrayView.isHidden = true
            orderReceviedGrayView.isHidden = true
            orderReceviedGreenMarkImageView.isHidden = false
            informationButton.isEnabled = false
        case "complete":
       
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
            changeOrderStatusPresenter.changeOrderStatus(status: "processing", caneclReson: "")
            informationButton.isEnabled = false
        case "processing":
            informationButton.isEnabled = false

            changeOrderStatusPresenter.changeOrderStatus(status: "complete", caneclReson: "")
       

        default:
            break
        }

      //  changeStatusDetails(status: status!)
        
    }
}
