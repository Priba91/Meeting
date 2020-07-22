//
//  WelcomeViewController.swift
//  ManGO
//
//  Created by Priba on 7/4/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import LGButton

class WelcomeViewController: BaseViewController {
    
    var phone = ""
    var verificationId = 0
    
    @IBOutlet weak var topLbl: UILabel!
    
    @IBOutlet weak var addAddressBtn: LGButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var bottomLbl: UILabel!
    
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var welcomeDescLbl: UILabel!
    
    
    let style : MDCTextInputControllerUnderline? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dissmissWelcome))
        welcomeView.addGestureRecognizer(gesture)
    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        
        addAddressBtn.setHalfCornerRadius()
        
    }
    
    override func setupStrings() {
        
        addAddressBtn.setupForTitleKey(key: "add_delivery_address")
        skipBtn.setupTitleForKey(key: "skip")

        topLbl.setupTitleForKey(key: "welcome_header")
        bottomLbl.setupTitleForKey(key: "welcome_footer")
        
        welcomeLbl.setupTitleForKey(key: "welcome")
        welcomeDescLbl.setupTitleForKey(key: "welcome_desc")
        
    }
    
    override func loadData() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            self.dissmissWelcome()
        }
    }
    
    @objc func dissmissWelcome(){
        self.welcomeView.isHidden = true
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        self.view.window!.layer.add(transition, forKey: kCATransition)
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
    
    @IBAction func addAddressBtnAction(_ sender: Any) {
        let vc =  UIStoryboard(name: "Address", bundle: nil).instantiateViewController(withIdentifier: "SelectAddressViewController") as! SelectAddressViewController
        vc.calledFromRegistration = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func skipBtnAction(_ sender: Any) {
        let vc =  UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
    
