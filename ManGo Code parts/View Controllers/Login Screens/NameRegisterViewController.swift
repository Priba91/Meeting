//
//  NameRegisterViewController.swift
//  ManGO
//
//  Created by Priba on 7/8/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import LGButton

class NameRegisterViewController: BaseViewController {
    
    var phone = ""
    var email = ""
    var verificationId = 0
    
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var nameTF: MDCTextField!
    
    @IBOutlet weak var nextBtn: LGButton!
    @IBOutlet weak var bottomLbl: UILabel!
    
    let style : MDCTextInputControllerUnderline? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        
        arrayOftextFieldControllerUnderline.append(nameTF.setupInitUnderlineState(returnKeyType: .done))
        
        //sendBtn.setElevation(ShadowElevation(rawValue: 5), for: .normal)
        nextBtn.setHalfCornerRadius()
        
    }
    
    override func setupStrings() {
        
        nextBtn.setupForTitleKey(key: "next")
        
        topLbl.setupTitleForKey(key: "registration_2_3")
        bottomLbl.setupTitleForKey(key: "enter_email_footer")
        nameTF.placeholder = LanguageManager.sharedInstance.getStringForKey(key: "username")

        
    }
    
    override func loadData() {
        
    }
    
    func validate() -> Bool{
        if nameTF.text == "" {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "must_enter_name"))
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
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        if validate() {
            let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AvatarRegisterViewController") as! AvatarRegisterViewController
            vc.email = email
            vc.phone = phone
            vc.username = nameTF.text ?? ""
            vc.verificationId = verificationId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func helpBtnAction(_ sender: Any) {
        //TODO: WHY PHONE NUMBER
    }
    
}
