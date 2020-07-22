//
//  SocialMediasAlert.swift
//  ManGO
//
//  Created by Priba on 7/1/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class WorkingHoursAlert: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var monLbl: UILabel!
    @IBOutlet weak var monValueLbl: UILabel!

    @IBOutlet weak var thuLbl: UILabel!
    @IBOutlet weak var thuValueLbl: UILabel!

    @IBOutlet weak var wenLbl: UILabel!
    @IBOutlet weak var wenValueLbl: UILabel!

    @IBOutlet weak var thyLbl: UILabel!
    @IBOutlet weak var thyValueLbl: UILabel!

    @IBOutlet weak var friLbl: UILabel!
    @IBOutlet weak var friValueLbl: UILabel!

    @IBOutlet weak var satLbl: UILabel!
    @IBOutlet weak var satValueLbl: UILabel!

    @IBOutlet weak var sunLbl: UILabel!
    @IBOutlet weak var sunValueLbl: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    var resturant = ResturantModel()

    override func viewDidLoad() {
        backView.layer.cornerRadius = 10
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped)))
        
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.alpha = 0.6
        visualEffectView.frame = self.view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(visualEffectView, at: 0)

        titleLbl.setupTitleForKey(key: "working_hours")
        
        monLbl.setupTitleForKey(key: "mon")
        thuLbl.setupTitleForKey(key: "thu")
        wenLbl.setupTitleForKey(key: "wen")
        thyLbl.setupTitleForKey(key: "thy")
        friLbl.setupTitleForKey(key: "fri")
        satLbl.setupTitleForKey(key: "sat")
        sunLbl.setupTitleForKey(key: "sun")
        
        monValueLbl.text = resturant.monday
        thuValueLbl.text = resturant.tuesday
        wenValueLbl.text = resturant.wednesday
        thyValueLbl.text = resturant.thursday
        friValueLbl.text = resturant.friday
        satValueLbl.text = resturant.saturday
        sunValueLbl.text = resturant.sunday

    }
    
    @objc func backgroundViewTapped(sender:AnyObject)
    {
        dismiss(animated: true, completion: nil)
    }
    

}
