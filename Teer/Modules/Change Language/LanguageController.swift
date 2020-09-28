//
//  LanguageController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/23/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import iOSDropDown
import MOLH
class LanguageController: UIViewController {

    @IBOutlet weak var chooseLanguageDropDown: DropDown!
    
    
    @IBOutlet weak var nextBTN: CustomBtn!
    
    
    @IBOutlet weak var flage: UIButton!
    
    
    @IBOutlet weak var lb: UILabel!
    
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBAction func onNextTapped(_ sender: Any) {
        validate()
       
    }
    func validate()
    {
        guard let text = chooseLanguageDropDown.text, !text.isEmpty else{
            ShowAlertView.showAlert(title: "", msg: "select_language".localize, sender: self)
            return
        }
        if text == "Arabic" {
            MOLH.setLanguageTo("ar")
        }
         if text == "English" {
            MOLH.setLanguageTo("en")
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Login", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginScreen") as! UIViewController
        //nextViewController.modalTransitionStyle = .flipHorizontal
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
//        chooseLanguageDropDown.inputView = UIView()

       
        flage.imageView?.contentMode = .scaleToFill
        chooseLanguageDropDown.delegate = self
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = #colorLiteral(red: 0.7954400182, green: 0.7955744863, blue: 0.7954223156, alpha: 1)
        nextBTN.setTitle("next".localize, for: .normal)
        chooseLanguageDropDown.roundAndShodowTextField()
              chooseLanguageDropDown.optionArray = ["عربي", "English"]
          //Its Id Values and its optional
          //messageDropDown.optionIds = [1,23,54,22]
       // flage.imageView?.contentMode = UIView.ContentMode.scaleToFill
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            chooseLanguageDropDown.text = "عربي"
            flage.setImage(UIImage(named: "ar_flag"), for: .normal)
        }
           
        else if MOLHLanguage.currentAppleLanguage() == "en"{
            chooseLanguageDropDown.text = "English"
            flage.setImage(UIImage(named: "en_flag"), for: .normal)
        }
            
//
          chooseLanguageDropDown.optionImageArray = ["ar_flag","en_flag"]
          chooseLanguageDropDown.didSelect{(selectedText , index ,id) in
            print("lang\(selectedText)")
            if selectedText == "عربي" {
                self.flage.setImage(UIImage(named: "ar_flag"), for: .normal)

            }
            else if selectedText == "English" {
                self.flage.setImage(UIImage(named: "en_flag"), for: .normal)

            }
           
    }
        
//        self.listen2Keyboard(withView: containerView)
    }
    override init(nibName : String?, bundle : Bundle?) {
        
        super.init(nibName: nibName, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}
extension LanguageController : UITextFieldDelegate{
   
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          self.view.endEditing(true)
          return false
      }
      func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
    
            return false
          }

}
