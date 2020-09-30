//
//  ContactUsViewController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/12/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import iOSDropDown
import MOLH

class ContactUsViewController: UIViewController, ContactUsVCProtocol {

    var contactUsModel = ContactUsPresenter(contactModel: ContactUsModel())
    let presenter = ContactUsPresenter(contactModel: ContactUsModel())
       let toastMessage = ToastMessages()
    
    @IBOutlet weak var send: CustomBtn!
    @IBOutlet weak var messageTitle: UITextField!
    @IBOutlet weak var messageDropDown: DropDown!
    @IBOutlet weak var messageBody: UITextView!
    
    @IBOutlet weak var backBtnImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        messageDropDown.inputView = UIView.init(frame: CGRect.zero)
        messageDropDown.inputAccessoryView = UIView.init(frame: CGRect.zero)
        messageBody.delegate = self
        messageTitle.roundAndShodowTextField()
        messageTitle.placeholder = "message_title".localize
        messageDropDown.placeholder = "message_type".localize
        messageDropDown.roundAndShodowTextField()
        messageBody.layer.cornerRadius = 20
        messageBody.layer.borderWidth = 1.0
        messageBody.layer.borderColor = #colorLiteral(red: 0.7954400182, green: 0.7955744863, blue: 0.7954223156, alpha: 1)
        messageBody.textColor = .lightGray
        messageTitle.layer.cornerRadius = 20
        messageTitle.layer.borderWidth = 1.0
        messageTitle.layer.borderColor = #colorLiteral(red: 0.7954400182, green: 0.7955744863, blue: 0.7954223156, alpha: 1)
        messageDropDown.layer.cornerRadius = 20
        messageDropDown.layer.borderWidth = 1.0
        messageDropDown.layer.borderColor = #colorLiteral(red: 0.7954400182, green: 0.7955744863, blue: 0.7954223156, alpha: 1)
        messageBody.text = "Message Body".localize
        // The list of array to display. Can be changed dynamically
        messageDropDown.optionArray = ["Complaint", "Suggestion", "Order", "Other"]
        //Its Id Values and its optional
        //messageDropDown.optionIds = [1,23,54,22]

        // Image Array its optional
       // messageTypeDropDown.ImageArray = []
        // The the Closure returns Selected Index and String
        messageDropDown.didSelect{(selectedText , index ,id) in
        //self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
        }
//        self.listen2Keyboard(withView: self.send)

        if  MOLHLanguage.isArabic(){
               self.backBtnImage.transform = self.backBtnImage.transform.rotated(by: CGFloat(Double.pi))
            messageBody.textAlignment = .right
        }
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       presenter.setVCDelegate(vcDelegate: self)
    }
    
    @IBAction func inSendBtnTapped(_ sender: Any) {
        self.presenter.contactUS(title: messageTitle.text!, type: messageDropDown.text!, message: messageBody.text!)
    }
    
    
    @IBAction func onBackBtnTapped(_ sender: Any) {
//        goToHomeScreen()
        dismiss(animated: true, completion: nil)
    }
    
    
    func goToHomeScreen() {
    
        let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
            self.present(view, animated: true, completion: nil)
        
        }
        
        func showAlert(msg: String) {
            toastMessage.createToastMessage(msg)
        }
}
    extension ContactUsViewController: UITextViewDelegate{
        func textViewDidBeginEditing(_ textView: UITextView)
        {
            if (textView.text == "Message Body".localize && textView.textColor == .lightGray)
            {
                textView.text = ""
                textView.textColor = .black
            }
            textView.becomeFirstResponder() //Optional
        }

        func textViewDidEndEditing(_ textView: UITextView)
        {
            if (textView.text == "")
            {
                textView.text = "Message Body".localize
                textView.textColor = .lightGray
            }
            textView.resignFirstResponder()
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
