//
//  RetrieveingOrder.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/14/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit

class RetrieveingOrderViewController: UIViewController,RetrieveingOrderProtocol,UITextViewDelegate  {
    
    
    let toastMessage = ToastMessages()
    var status = ""
    @IBOutlet weak var retrieveingOrderView: UIView!
    
    @IBOutlet weak var retrieveingOrderPopupView: UIView!
    @IBOutlet weak var retrieveingOrderTextView: UITextView!
    
    @IBOutlet weak var retrieveingReasonSentSuccufullyView: UIView!
    let messageTextViewMaxHeight: CGFloat = 170

    let presenter = RetrieveingOrderPresenter(retrieveingOrderModel: RetrieveingOrderModel())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ststua\(status)")
        hideKeyboardWhenTappedAround()
//        retrieveingOrderTextView.isHidden = false
        presenter.setVCDelegate(vcDelegate: self)
//        retrieveingOrderTextView.layer.masksToBounds = true
//        retrieveingOrderTextView.clipsToBounds = true
//        retrieveingOrderTextView.sizeToFit()
        retrieveingOrderTextView.textColor = UIColor.lightGray
        retrieveingOrderTextView.delegate = self
        retrieveingOrderPopupView.layer.cornerRadius = 20
        retrieveingOrderPopupView.layer.masksToBounds = true
        retrieveingOrderTextView.layer.cornerRadius = 20
        retrieveingOrderTextView.layer.masksToBounds = true
        retrieveingOrderTextView.layer.shadowOpacity = 0.2
        retrieveingOrderTextView.layer.shadowOffset = CGSize(width: 3, height: 3)
        retrieveingReasonSentSuccufullyView.layer.cornerRadius = 20
        retrieveingReasonSentSuccufullyView.layer.masksToBounds = true
        if status == "complete" {
            retrieveingOrderTextView.text = "complete_reason".localize

        }
        else if status == "cancel" {
            retrieveingOrderTextView.text = "retrieveing reason".localize

        }

        else {
            retrieveingOrderTextView.text = "retrieveing reason".localize
//
        }
        let retrieveingReasonSentSuccufullyViewGesture = UITapGestureRecognizer(target: self, action:  #selector (hideView(_:)))
        self.retrieveingReasonSentSuccufullyView.addGestureRecognizer(retrieveingReasonSentSuccufullyViewGesture)
    }
    
    @IBAction func cancelRetrieveingOrderBtnDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
//        retrieveingOrderTextView.contentSize = UIEdgeInsets.zero
        if retrieveingOrderTextView.textColor == UIColor.lightGray {
            retrieveingOrderTextView.text = nil
            retrieveingOrderTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if retrieveingOrderTextView.text.isEmpty {
            retrieveingOrderTextView.text = "retrieveing reason"
            retrieveingOrderTextView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
     
       }
    
   
    @IBAction func sendRetrieveingOrderReasonBtnDidTapped(_ sender: Any) {
        if !retrieveingOrderTextView.text.isEmpty{
            print("ststus\(status)")
            presenter.submitRetrieveingOrder(reason: retrieveingOrderTextView.text, status: self.status)
            
        }
        else{
            toastMessage.createToastMessage("you should enter retrieveing reason")
            
        }
        
    }
    func showAlert(msg: String) {
        toastMessage.createToastMessage(msg)
    }
    
    func displayOrderData() {
        retrieveingOrderPopupView.isHidden = true
        //     setView(view: retrieveingReasonSentSuccufullyView, hidden: true)
        self.retrieveingReasonSentSuccufullyView.isHidden = false

        let view = UIStoryboard(name: "NewOrderDetails", bundle: nil).instantiateViewController(withIdentifier: "NewOrderDetailsViewController") as! NewOrderDetailsViewController
                      view.view_type = "table_view"

        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.present(view, animated: true, completion: nil)

        }

//        performSegue(withIdentifier: "orderDetails", sender:self)

       
    
             
        
    }
    
    
    
    
    @objc func hideView(_ sender:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    // update for Swift UI
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
            //  self.dismiss(animated: true, completion: nil)
        })
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
     }
     
     @objc func dismissKeyboard() {
    view.endEditing(true)
         // do someting...
     }
    
}
extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
