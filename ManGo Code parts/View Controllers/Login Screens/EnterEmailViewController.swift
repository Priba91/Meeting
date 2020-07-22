//
//  EnterEmailViewController.swift
//  ManGO
//
//  Created by Priba on 7/4/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import LGButton

class EnterEmailViewController: BaseViewController {
    
    var phone = ""
    var verificationId = 0

    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var emailTF: MDCTextField!
    
    @IBOutlet weak var nextBtn: LGButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var bottomLbl: UILabel!
    
    let style : MDCTextInputControllerUnderline? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        
        arrayOftextFieldControllerUnderline.append(emailTF.setupInitUnderlineState(returnKeyType: .done))
        
        //sendBtn.setElevation(ShadowElevation(rawValue: 5), for: .normal)
        nextBtn.setHalfCornerRadius()
        
    }
    
    override func setupStrings() {
        
        nextBtn.setupForTitleKey(key: "register")
        
        topLbl.setupTitleForKey(key: "registration_1_3")
        bottomLbl.setupTitleForKey(key: "enter_email_footer")
        emailTF.placeholder = LanguageManager.sharedInstance.getStringForKey(key: "email")
        
        let string1 = LanguageManager.sharedInstance.getStringForKey(key: "why")
        let string2 = LanguageManager.sharedInstance.getStringForKey(key: "your_email")
        let string3 = "?"
        
        let att = NSMutableAttributedString(string: "\(string1) \(string2)\(string3)");
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location: 0, length: string1.count))
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mangoGreen, range: NSRange(location: string1.count + 1, length: string2.count + 1))
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location: att.string.count - 1, length: 1))
        helpBtn.setAttributedTitle(att, for: .normal)
        
    }
    
    override func loadData() {

    }
    
    func validate() -> Bool{
        if !Utils.isValidEmail(enteredEmail: emailTF.text ?? "") {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "wrong_email_format"))
            return false
        }
        
        return true
    }
    
    //MARK: - TextField Delegate
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    override func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
    }
    
    //MARK: - Buttons Actions
    
    @IBAction func sendBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        if validate() {
            
            let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NameRegisterViewController") as! NameRegisterViewController
            vc.email = emailTF.text ?? ""
            vc.phone = phone
            vc.verificationId = verificationId
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @IBAction func helpBtnAction(_ sender: Any) {
        //TODO: WHY PHONE NUMBER
    }
    
}
