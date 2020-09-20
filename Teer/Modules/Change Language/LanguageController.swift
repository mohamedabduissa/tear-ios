//
//  LanguageController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/23/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import iOSDropDown

class LanguageController: UIViewController {

    @IBOutlet weak var chooseLanguageDropDown: DropDown!
    
    @IBAction func onNextTapped(_ sender: Any) {
        validate()
       
    }
    func validate()
    {
        guard let text = chooseLanguageDropDown.text, !text.isEmpty else{
            ShowAlertView.showAlert(title: "", msg: "select_language".localize, sender: self)
            return
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Login", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginScreen") as! UIViewController
        //nextViewController.modalTransitionStyle = .flipHorizontal
        self.present(nextViewController, animated:true, completion:nil)
    }
    override func viewDidLoad() {
        
        chooseLanguageDropDown.roundAndShodowTextField()
              chooseLanguageDropDown.optionArray = ["Arabic", "English"]
          //Its Id Values and its optional
          //messageDropDown.optionIds = [1,23,54,22]

          // Image Array its optional
          chooseLanguageDropDown.optionImageArray = ["ar_flag","en_flag"]
          // The the Closure returns Selected Index and String
//          chooseLanguageDropDown.didSelect{(selectedText , index ,id) in
//          //self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
//          }
    }
    override init(nibName : String?, bundle : Bundle?) {
        
        super.init(nibName: nibName, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
