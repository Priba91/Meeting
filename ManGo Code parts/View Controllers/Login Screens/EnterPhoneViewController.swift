//
//  EnterPhoneViewController.swift
//  ManGO
//
//  Created by Priba on 7/2/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import LGButton
import PhoneNumberKit

class EnterPhoneViewController: BaseViewController {
    
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var shortCodeTF: MDCTextField!
    @IBOutlet weak var phoneTF: MDCTextField!
    
    @IBOutlet weak var sendBtn: LGButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var bottomLbl: UILabel!
    @IBOutlet weak var termsBtn: UIButton!
    
    let style : MDCTextInputControllerUnderline? = nil
    let phoneNumberKit = PhoneNumberKit()

    var tryCount = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()

        tryCount = 0
        loginSavedUser()
        
    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        
        phoneIcon.tintColor = .white
        
        arrayOftextFieldControllerUnderline.append(shortCodeTF.setupInitUnderlineState(returnKeyType: .next, tintColor: .white))
        arrayOftextFieldControllerUnderline.append(phoneTF.setupInitUnderlineState(returnKeyType: .next, tintColor: .white))
        
        shortCodeTF.textColor = .white
        phoneTF.textColor = .white
        
        helpBtn.setTitleColor(.white, for: .normal)

        sendBtn.setHalfCornerRadius()

    }
    
    override func setupStrings() {
        
        sendBtn.setupForTitleKey(key: "send")
        
        bottomLbl.setupTitleForKey(key: "terms_footer")
        termsBtn.setupTitleForKey(key: "terms_and_conditions")
        
        let string1 = LanguageManager.sharedInstance.getStringForKey(key: "why")
        let string2 = LanguageManager.sharedInstance.getStringForKey(key: "phone_number_tint")
        let string3 = "?"
        
        let att = NSMutableAttributedString(string: "\(string1) \(string2)\(string3)");
        att.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0, length: string1.count))
        att.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12, weight: .bold), range: NSRange(location: string1.count + 1, length: string2.count + 1))
        att.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: att.string.count - 1, length: 1))
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: att.string.count))
        helpBtn.setAttributedTitle(att, for: .normal)
        
    }
    
    override func loadData() {
        shortCodeTF.text = "\(NPPhoneValidator.sharedInstance.getNumericCountryCode())"
    }
    
    func validate() -> Bool{
        
        shortCodeTF.cleanSpacesAndNewLines()
        if shortCodeTF.text?.count ?? 0 < 2 {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "short_code_empty"))
            return false
        }
        
        phoneTF.cleanSpacesAndNewLines()
        if phoneTF.text?.count ?? 0 < 1 {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "phone_number_empty"))
            return false
        }
        
        do {
            _ = try phoneNumberKit.parse((shortCodeTF.text ?? "") + (phoneTF.text ?? ""))
        }
        catch {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "entered_phone_number_not_valid"))
            return false
            
        }
        
        return true
    }
    
    func loginSavedUser(){
        if UserDefaults.standard.object(forKey: "authToken") != nil{

            guard let phone = UserDefaults.standard.object(forKey: "phone") as? String else{
                return
            }
            guard let uid = UserDefaults.standard.object(forKey: "uid") as? String else{
                return
            }
            super.presentSplashLoader()

            ServerManager.sharedInstance.login(phone: phone, uid: uid) { (response, success, error) in
                
                if(success!){
                    
                    if let jwt = response["jwt"] as? String, let userDict = response["user"] as? NSDictionary {
                        
                        let formater = DateFormatter()
                        formater.dateFormat = "dd.MM.yyyy HH:mm"
                        UserDefaults.standard.set(formater.string(from: Date()), forKey: "lastLoginDate")
                        
                        UserDefaults.standard.set(jwt, forKey: "authToken")
                        
                        DataManager.sharedInstance.logedUser = UserModel.init(dict: userDict)
                        DataManager.sharedInstance.mainFilter = FilterModel(dict: UserDefaults.standard.dictionary(forKey: "mainFilter") as NSDictionary? ?? [:] as NSDictionary)
                        
                        let vc =  UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                        DataManager.sharedInstance.loadTypes(dict: response)

                        self.navigationController?.pushViewController(vc, animated: true)
                        super.dismissSplashLoader()
                    }else{
                        
                        if self.tryCount < 3 {
                            self.tryCount += 1
                            self.loginSavedUser()
                            
                        }else{
                            
                            super.dismissSplashLoader()
                        }
                    }
                    
                }else{
                    AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: error, completion: { (index, str) in
                        
                    })
                }
            }
        }else{
            super.dismissSplashLoader()
        }
    }

    
    //MARK: - TextField Delegate
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    override func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == shortCodeTF {
            phoneTF.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == shortCodeTF && shortCodeTF.text?.count == 4 && string != "" {
            return false
        }
        return true
    }
    
    @IBAction func shortCodeTFChanged(_ sender: Any) {
        if shortCodeTF.text?.count == 1 && shortCodeTF.text != "+"{
            shortCodeTF.text = "\(shortCodeTF.text!)"
        }
    }
    
    
    @IBAction func phoneTFChanged(_ sender: Any) {
    }
    
    func checkButtonState(){
        if shortCodeTF.text?.count ?? 0 < 2 {
            

        }
        if phoneTF.text?.count ?? 0 < 1 {
            
        }
    }
    
    //MARK: - Buttons Actions
    
    @IBAction func sendBtnAction(_ sender: Any) {
        
        if validate() {
            sendBtn.isLoading = true
            let phone = "+\(shortCodeTF.text!)\(phoneTF.text!)"
            
            ServerManager.sharedInstance.sendVerification(phone: phone) { (response, success, errMsg) in
                self.sendBtn.isLoading = false

                if success!, let id = response["id"] as? Int {
                    
                    let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhoneVerificationViewController") as! PhoneVerificationViewController
                    vc.id = id
                    vc.phone = phone
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                    AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                        
                    })
                }
            }
        }
    }
    
    @IBAction func helpBtnAction(_ sender: Any) {
        //TODO: WHY PHONE NUMBER
    }
    
    @IBAction func termsBtnAction(_ sender: Any) {
        //TODO:
    }
    
}

extension LGButton {
    func setupForTitleKey(key: String, uppercase: Bool = false){
        self.titleString = LanguageManager.sharedInstance.getStringForKey(key: key, uppercased: uppercase)
        self.fullyRoundedCorners = true
        self.loadingSpinnerColor = .mangoGreen
        self.bgColor = .white
        self.titleColor = .mangoGreen
        self.shadowColor = .black
        self.shadowOpacity = 0.3
        self.shadowRadius = 4
        self.shadowOffset = CGSize(width: 4, height: 4)
        self.titleFontSize = 16
    }
}
