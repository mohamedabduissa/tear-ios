//
//  ChangeLanguageViewController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/16/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MBRadioCheckboxButton
import MOLH
class ChangeLanguageViewController: UIViewController {
    var group3Container = RadioButtonContainer()
    
    @IBOutlet weak var englishLanguageRadioBtn: RadioButton!
    
    @IBOutlet weak var backBtnImage: UIButton!
    @IBOutlet weak var arabicLanguageRadioBtn: RadioButton!
    override func viewDidLoad(){
        super.viewDidLoad()
        group3Container.addButtons([englishLanguageRadioBtn, arabicLanguageRadioBtn])
        englishLanguageRadioBtn.radioCircle = RadioButtonCircleStyle.init(outerCircle: 20, innerCircle: 15, outerCircleBorder: 1)
        arabicLanguageRadioBtn.radioCircle = RadioButtonCircleStyle.init(outerCircle: 20, innerCircle: 15, outerCircleBorder: 1)
        arabicLanguageRadioBtn.radioButtonColor = RadioButtonColor(active: hexStringToUIColor(hex: "#D2415B"), inactive: hexStringToUIColor(hex: "#D2415B"))
        englishLanguageRadioBtn.radioButtonColor = RadioButtonColor(active: hexStringToUIColor(hex: "#D2415B"), inactive: hexStringToUIColor(hex: "#D2415B"))
        if  MOLHLanguage.isArabic(){
            self.backBtnImage.transform = self.backBtnImage.transform.rotated(by: CGFloat(Double.pi))
        }
        
    }
    
    @IBAction func saveBtnDidTapped(_ sender: Any) {
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset(transition: .transitionCrossDissolve, duration: 0.25)
        MOLH.reset()
        
    }
    @IBAction func arbicLangaugeBtnDidTapped(_ sender: Any) {
        MOLHLanguage.setAppleLAnguageTo("en")
        
    }
    
    @IBAction func englishLanguageBtnDidTapped(_ sender: Any) {
        MOLHLanguage.setAppleLAnguageTo("ar")
    }
    
    @IBAction func backBtnDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
