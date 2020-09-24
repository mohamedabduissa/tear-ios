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
    
    @IBOutlet weak var retrieveingOrderView: UIView!
    
    @IBOutlet weak var retrieveingOrderPopupView: UIView!
    @IBOutlet weak var retrieveingOrderTextView: UITextView!
    
    @IBOutlet weak var retrieveingReasonSentSuccufullyView: UIView!
    
    let presenter = RetrieveingOrderPresenter(retrieveingOrderModel: RetrieveingOrderModel())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        presenter.setVCDelegate(vcDelegate: self)
        
        retrieveingOrderTextView.text = "retrieveing reason".localize
        retrieveingOrderTextView.textColor = UIColor.lightGray
        retrieveingOrderTextView.delegate = self
        retrieveingOrderPopupView.layer.cornerRadius = 20
        retrieveingOrderPopupView.layer.masksToBounds = true
        retrieveingOrderTextView.layer.cornerRadius = 20
        retrieveingOrderTextView.layer.masksToBounds = false
        retrieveingOrderTextView.layer.shadowOpacity = 0.2
        retrieveingOrderTextView.layer.shadowOffset = CGSize(width: 3, height: 3)
        retrieveingReasonSentSuccufullyView.layer.cornerRadius = 20
        retrieveingReasonSentSuccufullyView.layer.masksToBounds = true
        
        
        
        let retrieveingReasonSentSuccufullyViewGesture = UITapGestureRecognizer(target: self, action:  #selector (hideView(_:)))
        self.retrieveingReasonSentSuccufullyView.addGestureRecognizer(retrieveingReasonSentSuccufullyViewGesture)
    }
    
    @IBAction func cancelRetrieveingOrderBtnDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
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
    
    @IBAction func sendRetrieveingOrderReasonBtnDidTapped(_ sender: Any) {
        if !retrieveingOrderTextView.text.isEmpty{
            presenter.submitRetrieveingOrder(reason: retrieveingOrderTextView.text)}
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
        retrieveingReasonSentSuccufullyView.isHidden = false
        
        
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
