//
//  PhoneVerificationViewController.swift
//  ManGO
//
//  Created by Priba on 7/2/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import LGButton

class PhoneVerificationViewController: BaseViewController {
    
    @IBOutlet weak var headerLbl: UILabel!
    
    
    @IBOutlet weak var firstNumTF: UITextField!
    @IBOutlet weak var secondNumTF: UITextField!
    @IBOutlet weak var thirdNumTF: UITextField!
    @IBOutlet weak var fourthNumTF: UITextField!
    @IBOutlet weak var fifththNumTF: UITextField!
    @IBOutlet weak var sixthNumTF: UITextField!

    @IBOutlet weak var nextBtn: LGButton!
    @IBOutlet weak var bottomLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    
    @IBOutlet weak var timerLbl: UILabel!
    
    var timer = Timer()
    var phone = ""
    var id = 0
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackTapDissmisKeyboardGesture()
        startTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstNumTF.becomeFirstResponder()
    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        nextBtn.setupForTitleKey(key: "next")
        resendBtn.setupTitleForKey(key: "resend_code", uppercased: true)
        headerLbl.setupTitleForKey(key: "send_code_desc")
    }
    
    override func setupStrings() {
        
    }
    
    override func loadData() {
        
    }

    func startTimer(){
        seconds = 120
        resendBtn.isHidden = true
        timerLbl.isHidden = false
        timerLbl.text = "02:00"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer.invalidate()
        resendBtn.isHidden = false
        timerLbl.isHidden = true
    }
    
    @objc func timerAction(){
        seconds -= 1
        
        if seconds == 0{
            stopTimer()
            return
        }
        
        timerLbl.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    //MARK: - TextField Delegate
    
    @IBAction func textFieldEditigChanged(_ sender: UITextField) {
        
        if sender.text?.count == 0 {
            return
        }
        
        if sender.text?.count == 2 {
            sender.text = String(sender.text!.last!)
        }
        
        if sender == firstNumTF {
            secondNumTF.text = " "
            secondNumTF.becomeFirstResponder()
        }else if sender == secondNumTF{
            thirdNumTF.text = " "
            thirdNumTF.becomeFirstResponder()
        }else if sender == thirdNumTF{
            fourthNumTF.text = " "
            fourthNumTF.becomeFirstResponder()
        }else if sender == fourthNumTF{
            fifththNumTF.text = " "
            fifththNumTF.becomeFirstResponder()
        }else if sender == fifththNumTF{
            sixthNumTF.text = " "
            sixthNumTF.becomeFirstResponder()
        }else if sender == sixthNumTF{
            self.view.endEditing(true)
            nextBtnAction(nextBtn!)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == ""{
            textField.text = ""
            if textField == firstNumTF {
                
            }else if textField == secondNumTF{
                firstNumTF.text = " "
                firstNumTF.becomeFirstResponder()
            }else if textField == thirdNumTF{
                secondNumTF.text = " "
                secondNumTF.becomeFirstResponder()
            }else if textField == fourthNumTF{
                thirdNumTF.text = " "
                thirdNumTF.becomeFirstResponder()
            }else if textField == fifththNumTF{
                fourthNumTF.text = " "
                fourthNumTF.becomeFirstResponder()
            }else if textField == sixthNumTF{
                fifththNumTF.text = " "
                fifththNumTF.becomeFirstResponder()

            }
            return false
        }
        
        return true
    }
    
    func validate()-> Bool{
        
        firstNumTF.cleanSpacesAndNewLines()
        if firstNumTF.text!.count < 1 {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "must_fill_all_fields"))
            return false
        }
        
        secondNumTF.cleanSpacesAndNewLines()
        if secondNumTF.text!.count < 1 {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "must_fill_all_fields"))
            return false
        }
        
        thirdNumTF.cleanSpacesAndNewLines()
        if thirdNumTF.text!.count < 1 {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "must_fill_all_fields"))
            return false
        }
        
        fourthNumTF.cleanSpacesAndNewLines()
        if fourthNumTF.text!.count < 1 {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "must_fill_all_fields"))
            return false
        }
        
        fifththNumTF.cleanSpacesAndNewLines()
        if fifththNumTF.text!.count < 1 {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "must_fill_all_fields"))
            return false
        }
        
        sixthNumTF.cleanSpacesAndNewLines()
        if sixthNumTF.text!.count < 1 {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "must_fill_all_fields"))
            return false
        }

        return true
    }
    
    //MARK: - Buttons Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        if validate() {
            let code = "\(firstNumTF.text!)\(secondNumTF.text!)\(thirdNumTF.text!)\(fourthNumTF.text!)\(fifththNumTF.text!)\(sixthNumTF.text!)"
            nextBtn.isLoading = true
            //TODO:
            ServerManager.sharedInstance.checkVerification(phone: phone, code: code, id: id) { (response, success, errMsg, statusCode) in
                if success!{
                    
                    if statusCode == 200 {
                      
                        guard let uid = response["uid"] as? String else{
                            return
                        }
                        
                        ServerManager.sharedInstance.login(phone: self.phone, uid: uid, completition: { (response, success, errMsg) in
                            if(success!){
                                
                                if let jwt = response["jwt"] as? String, let userDict = response["user"] as? NSDictionary {
                                    
                                    let formater = DateFormatter()
                                    formater.dateFormat = "dd.MM.yyyy HH:mm"
                                    UserDefaults.standard.set(formater.string(from: Date()), forKey: "lastLoginDate")
                                    
                                    DataManager.sharedInstance.loadAddresses()
                                    UserDefaults.standard.set(jwt, forKey: "authToken")
                                    UserDefaults.standard.set(self.phone, forKey: "phone")
                                    UserDefaults.standard.set(uid, forKey: "uid")
                                    DataManager.sharedInstance.logedUser = UserModel.init(dict: userDict)
                                    NotificationCenter.default.post(name: Notification.Name(rawValue: "dismissSplashLoader"), object: nil)
                                    
                                    DataManager.sharedInstance.loadTypes(dict: response)
                                    
                                    
                                    let vc =  UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                                    
                                }else{
                                    AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                                        
                                    })
                                }
                                
                            }else{
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "dismissSplashLoader"), object: nil)
                            }
                        })
                        
                    }else if statusCode == 400 {
                        AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "wrong_code_title"), aStrMessage: LanguageManager.sharedInstance.getStringForKey(key: "wrong_code_msg"), completion: { (index, str) in
                            
                        })

                        
                    }else if statusCode == 405{
                        self.nextBtn.isLoading = false
                        
                        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistrationGroupedViewController") as! RegistrationGroupedViewController
                        vc.verificationId = self.id
                        vc.phone = self.phone
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: LanguageManager.sharedInstance.getStringForKey(key: "code_verification_error_msg"), completion: { (index, str) in
                            
                        })
                    }
                    
                }else{
                    self.nextBtn.isLoading = false

                    AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                        
                    })
                }
            }
        }
    }
    
    @IBAction func resendCodeBtn(_ sender: Any) {
        nextBtn.isLoading = true
        ServerManager.sharedInstance.sendVerification(phone: phone) { (response, success, errMsg) in
            self.nextBtn.isLoading = false
            
            if success!, let id = response["id"] as? Int {
                
                self.id = id
                self.startTimer()
                
            }else{
                AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                    
                })
            }
        }
    }
    
}
