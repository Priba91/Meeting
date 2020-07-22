//
//  SocialMediasAlert.swift
//  ManGO
//
//  Created by Priba on 7/1/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

protocol SocialMediaAlertDelegate: class {
    func facebookAction()
    func instagramAction()
    func snapchatAction()
}

class SocialMediasAlert: UIViewController {

    var delegate: SocialMediaAlertDelegate?
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    @IBOutlet weak var contactUs: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var instagramBtn: UIButton!
    @IBOutlet weak var snapchatBtn: UIButton!
    @IBOutlet weak var backView: UIView!

    override func viewDidLoad() {
        backView.layer.cornerRadius = 10
        facebookBtn.setHalfCornerRadius()
        instagramBtn.setHalfCornerRadius()
        snapchatBtn.setHalfCornerRadius()
        
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.alpha = 0.6
        visualEffectView.frame = self.view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped)))
        self.view.insertSubview(visualEffectView, at: 0)

        titleLbl.setupTitleForKey(key: "contact_us")
        messageLbl.setupTitleForKey(key: "contact_us_description")
        contactUs.setupTitleForKey(key: "send_us_message")
    }
    
    @objc func backgroundViewTapped(sender:AnyObject)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fbAction(_ sender: Any) {
        delegate?.facebookAction()
    }
    @IBAction func igAction(_ sender: Any) {
        delegate?.instagramAction()
    }
    @IBAction func snapAction(_ sender: Any) {
        delegate?.snapchatAction()
    }
    
}
