//
//  TermsViewController.swift
//  ManGO
//
//  Created by Priba on 7/9/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import LGButton

class TermsViewController: BaseViewController {
    
    var phone = ""
    var verificationId = 0
    
    @IBOutlet weak var topLbl: UILabel!
    
    @IBOutlet weak var nextBtn: LGButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var midLbl: UILabel!
    
    @IBOutlet weak var topTermsLbl: UILabel!
    @IBOutlet weak var botTermsLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "authToken") != nil{
            
            let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EnterPhoneViewController") as! EnterPhoneViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        
        
        //sendBtn.setElevation(ShadowElevation(rawValue: 5), for: .normal)
        nextBtn.setHalfCornerRadius()
        
    }
    
    override func setupStrings() {
        
        nextBtn.setupForTitleKey(key: "use_mango")
        
        midLbl.setupTitleForKey(key: "its_great_to_see_you")
        topTermsLbl.setupTitleForKey(key: "terms_footer")
        botTermsLbl.setupTitleForKey(key: "terms_and_conditions")
        
    }
    
    override func loadData() {
        
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
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EnterPhoneViewController") as! EnterPhoneViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func termsBtnAction(_ sender: Any) {
        //TODO: TERMS
    }
}

