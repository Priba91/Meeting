//
//  DashboardViewController.swift
//  Linguado
//
//  Created by Priba on 3/10/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import Foundation
import MaterialComponents
import SDWebImage
import SwiftEntryKit

class DashboardViewController: UITabBarController, MDCBottomNavigationBarDelegate, UITabBarControllerDelegate {

    var botBar = MDCBottomNavigationBar()
    var botAddresBar = ShadowMaterialUpsideDownSharpView()
    var botAdrBarLeftLbl = UILabel()
    var botAdrBarRightLbl = UILabel()
    
    var sortBtn = UIButton()
    var filterBtn = UIButton()
    var searchBtn = UIButton()
    var notificationsBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        setupNavigationBar()
        setupBottomBar()
        updateAddressBar()

        NotificationCenter.default.addObserver(self, selector: #selector(pushNotificationReceived(notification:)), name: Notification.Name(rawValue: "pushNotificationReceived"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openNotificationUserInfo(notification:)), name: Notification.Name(rawValue: "openNotificationUserInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAddressBar), name: Notification.Name(rawValue: "updateAddressBar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(orderSentNotification), name: Notification.Name(rawValue: "orderSentNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deselectSearch), name: Notification.Name(rawValue: "deselectSearch"), object: nil)

        //Preload tab controllers
        self.viewControllers?.forEach { let _ = $0.view }
        
        
        //Opening notification on terminated application
        if UserDefaults.standard.bool(forKey: "openNotificationDidLunch") {
            UserDefaults.standard.set(false, forKey: "openNotificationDidLunch")
            
            guard let userInfo = UserDefaults.standard.dictionary(forKey: "lastUserInfo") else{
                return
            }
            
            guard let objectStr = userInfo["object"] as? String else{
                return
            }
            
            if let data = objectStr.data(using: .utf8) {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                    
                    let delivery = DeliveryModel(dict: json ?? [:])
                    
                    
                    let vc =  UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "TrackingDeliveryViewController") as! TrackingDeliveryViewController
                    vc.order = delivery.order
                    vc.deliveryObject = delivery
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }catch {

                }
        
            }

        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    //MARK: - Private methods

    func setupNavigationBar(){
        
        let screenSize = UIApplication.shared.keyWindow?.frame.size
        let barHeight:CGFloat = 50.0
        let barColor = UIColor.white
        
        //NAV BAR
        let navBar = UIView(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: screenSize?.width ?? 300, height: barHeight))
        navBar.backgroundColor = barColor
        self.view.addSubview(navBar)
        
        navBar.layer.applySketchShadow(color: UIColor.black, alpha: 0.06, x: 0, y: 8, blur: 9, spread: 0.5)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: navBar, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: navBar, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: navBar, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: navBar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        
        view.addConstraints([topConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        //COVER
        let cover = UIView(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: screenSize?.width ?? 300, height: barHeight))
        cover.backgroundColor = barColor
        self.view.addSubview(cover)
        
        cover.translatesAutoresizingMaskIntoConstraints = false
        
        let botConstraint1 = NSLayoutConstraint(item: cover, attribute: .bottom, relatedBy: .equal, toItem: navBar, attribute: .top, multiplier: 1, constant: 0)
        let leftConstraint1 = NSLayoutConstraint(item: cover, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint1 = NSLayoutConstraint(item: cover, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        let heightConstraint1 = NSLayoutConstraint(item: cover, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        
        view.addConstraints([botConstraint1, leftConstraint1, rightConstraint1, heightConstraint1])
        
        //LOGO
        
        let logoView = UIImageView()
        logoView.contentMode = .scaleAspectFit
        logoView.image = UIImage(named: "flat_logo")!
        navBar.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint2 = NSLayoutConstraint(item: logoView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: navBar, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint2 = NSLayoutConstraint(item: logoView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: navBar, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint2 = NSLayoutConstraint(item: logoView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 110)
        let heightConstraint2 = NSLayoutConstraint(item: logoView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
        view.addConstraints([horizontalConstraint2, verticalConstraint2, widthConstraint2, heightConstraint2])
        
        
        //FilterBtn
        
        filterBtn = UIButton()
        filterBtn.setTitle("", for: .normal)
        filterBtn.setImage(UIImage(named: "filter_icon")!, for: .normal)
        filterBtn.tintColor = UIColor.black
        filterBtn.addTarget(self, action: #selector(filterBtnAction), for: .touchUpInside)
        navBar.addSubview(filterBtn)
        filterBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint3 = NSLayoutConstraint(item: filterBtn, attribute: .top, relatedBy: .equal, toItem: navBar, attribute: .top, multiplier: 1, constant: 0)
        let rightConstraint3 = NSLayoutConstraint(item: filterBtn, attribute: .right, relatedBy: .equal, toItem: navBar, attribute: .right, multiplier: 1, constant: -8)
        let widthConstraint3 = NSLayoutConstraint(item: filterBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        let heightConstraint3 = NSLayoutConstraint(item: filterBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        navBar.addConstraints([topConstraint3, rightConstraint3, widthConstraint3, heightConstraint3])
        
        //SortBtn
        
        sortBtn = UIButton()
        sortBtn.setTitle("", for: .normal)
        sortBtn.setImage(UIImage(named: "sort_icon")!, for: .normal)
        sortBtn.tintColor = UIColor.black
        sortBtn.addTarget(self, action: #selector(sortBtnAction), for: .touchUpInside)
        navBar.addSubview(sortBtn)
        sortBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint4 = NSLayoutConstraint(item: sortBtn, attribute: .top, relatedBy: .equal, toItem: navBar, attribute: .top, multiplier: 1, constant: 0)
        let rightConstraint4 = NSLayoutConstraint(item: sortBtn, attribute: .right, relatedBy: .equal, toItem: filterBtn, attribute: .left, multiplier: 1, constant: 8)
        let widthConstraint4 = NSLayoutConstraint(item: sortBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        let heightConstraint4 = NSLayoutConstraint(item: sortBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        navBar.addConstraints([topConstraint4, rightConstraint4, widthConstraint4, heightConstraint4])
        
        //Search Btn
        
        searchBtn = UIButton()
        searchBtn.setTitle("", for: .normal)
        searchBtn.setImage(UIImage(named: "search")!, for: .normal)
        searchBtn.tintColor = UIColor.black
        searchBtn.addTarget(self, action: #selector(searchBtnAction), for: .touchUpInside)
        navBar.addSubview(searchBtn)
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint5 = NSLayoutConstraint(item: searchBtn, attribute: .top, relatedBy: .equal, toItem: navBar, attribute: .top, multiplier: 1, constant: 0)
        let leftConstraint5 = NSLayoutConstraint(item: searchBtn, attribute: .left, relatedBy: .equal, toItem: navBar, attribute: .left, multiplier: 1, constant: 8)
        let widthConstraint5 = NSLayoutConstraint(item: searchBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        let heightConstraint5 = NSLayoutConstraint(item: searchBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        navBar.addConstraints([topConstraint5, leftConstraint5, widthConstraint5, heightConstraint5])
        
        //Notifications Btn
        
        notificationsBtn = UIButton()
        notificationsBtn.setTitle("", for: .normal)
        notificationsBtn.setImage(UIImage(named: "icNotifications")!, for: .normal)
        notificationsBtn.tintColor = UIColor.black
        notificationsBtn.addTarget(self, action: #selector(notificationsBtnAction), for: .touchUpInside)
        navBar.addSubview(notificationsBtn)
        notificationsBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint6 = NSLayoutConstraint(item: notificationsBtn, attribute: .top, relatedBy: .equal, toItem: navBar, attribute: .top, multiplier: 1, constant: 0)
        let rightConstraint6 = NSLayoutConstraint(item: notificationsBtn, attribute: .left, relatedBy: .equal, toItem: searchBtn, attribute: .right, multiplier: 1, constant: 0)
        let widthConstraint6 = NSLayoutConstraint(item: notificationsBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        let heightConstraint6 = NSLayoutConstraint(item: notificationsBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        navBar.addConstraints([topConstraint6, rightConstraint6, widthConstraint6, heightConstraint6])
        
  }
    
    func setupBottomBar(){
        let screenSize = UIApplication.shared.keyWindow?.frame.size

        let underBar = UIView(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: screenSize?.width ?? 300, height: 150))
        underBar.backgroundColor = UIColor.white
        
        underBar.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: underBar, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: underBar, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: underBar, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        let botConstraint = NSLayoutConstraint(item: underBar, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        
        botBar = MDCBottomNavigationBar.init(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        botBar.items = [
            UITabBarItem(title: LanguageManager.sharedInstance.getStringForKey(key: "food"), image: UIImage(named: "food"), tag: 1),
            UITabBarItem(title: LanguageManager.sharedInstance.getStringForKey(key: "orders"), image: UIImage(named: "orders"), tag: 2),
            UITabBarItem(title: LanguageManager.sharedInstance.getStringForKey(key: "profile"), image: UIImage(named: "profile"), tag: 0),
        ]
        botBar.alignment = .justified
        botBar.titleVisibility = .selected
        botBar.elevation = .modalBottomSheet
        botBar.selectedItem = botBar.items.first
        botBar.backgroundColor = UIColor.white
        botBar.tintColor = UIColor.lightGray
        botBar.elevation = ShadowElevation.init(10)
        botBar.selectedItemTintColor = UIColor.mangoGreen
        botBar.unselectedItemTintColor = UIColor.lightGray
        
        botBar.itemTitleFont = UIFont.systemFont(ofSize: 14)
        botBar.delegate = self
        botBar.selectedItem = botBar.items[0]
        self.selectedIndex = 1
        
        self.view.addSubview(botBar)
        self.view.addSubview(underBar)
        view.addConstraints([topConstraint, leftConstraint, rightConstraint, botConstraint])

        botBar.translatesAutoresizingMaskIntoConstraints = false
        let botConstraint5 = NSLayoutConstraint(item: botBar, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: 0)
        let leftConstraint5 = NSLayoutConstraint(item: botBar, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint5 = NSLayoutConstraint(item: botBar, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        let heightConstraint5 = NSLayoutConstraint(item: botBar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 56 )
        view.addConstraints([botConstraint5, leftConstraint5, rightConstraint5, heightConstraint5])
        
        
        //Bot Address Bar
        
        botAddresBar.backgroundColor = .mangoGreen
        self.view.addSubview(botAddresBar)
        botAddresBar.translatesAutoresizingMaskIntoConstraints = false
        let botConstraint6 = NSLayoutConstraint(item: botAddresBar, attribute: .bottom, relatedBy: .equal, toItem: botBar, attribute: .top, multiplier: 1, constant: 0)
        let leftConstraint6 = NSLayoutConstraint(item: botAddresBar, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint6 = NSLayoutConstraint(item: botAddresBar, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        let heightConstraint6 = NSLayoutConstraint(item: botAddresBar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 44)
        view.addConstraints([botConstraint6, leftConstraint6, rightConstraint6, heightConstraint6])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addressBarAction))
        botAddresBar.addGestureRecognizer(tap)
        
        botAdrBarRightLbl.setupTitleForKey(key: "change", uppercased: false)
        botAdrBarRightLbl.textColor = .white
        botAdrBarRightLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        botAdrBarRightLbl.textAlignment = .right
        botAddresBar.addSubview(botAdrBarRightLbl)
        botAdrBarRightLbl.translatesAutoresizingMaskIntoConstraints = false
        let botConstraint7 = NSLayoutConstraint(item: botAdrBarRightLbl, attribute: .centerY, relatedBy: .equal, toItem: botAddresBar, attribute: .centerY, multiplier: 1, constant: 0)
        let leftConstraint7 = NSLayoutConstraint(item: botAdrBarRightLbl, attribute: .right, relatedBy: .equal, toItem: botAddresBar, attribute: .right, multiplier: 1, constant: -16)
        let widthConstraint7 = NSLayoutConstraint(item: botAdrBarRightLbl, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let heightConstraint7 = NSLayoutConstraint(item: botAdrBarRightLbl, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 44)
        view.addConstraints([botConstraint7, leftConstraint7, widthConstraint7, heightConstraint7])
        
        botAdrBarLeftLbl.textColor = .white
        botAdrBarLeftLbl.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        botAddresBar.addSubview(botAdrBarLeftLbl)
        botAdrBarLeftLbl.textAlignment = .left
        botAdrBarLeftLbl.clipsToBounds = true
        
        botAdrBarLeftLbl.translatesAutoresizingMaskIntoConstraints = false
        let botConstraint8 = NSLayoutConstraint(item: botAdrBarLeftLbl, attribute: .centerY, relatedBy: .equal, toItem: botAddresBar, attribute: .centerY, multiplier: 1, constant: 0)
        let leftConstraint8 = NSLayoutConstraint(item: botAdrBarLeftLbl, attribute: .left, relatedBy: .equal, toItem: botAddresBar, attribute: .left, multiplier: 1, constant: 16)
        let rightConstraint8 = NSLayoutConstraint(item: botAdrBarLeftLbl, attribute: .right, relatedBy: .equal, toItem: self.botAdrBarRightLbl, attribute: .right, multiplier: 1, constant: 0)
        let heightConstraint8 = NSLayoutConstraint(item: botAdrBarLeftLbl, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 44)
        view.addConstraints([botConstraint8, leftConstraint8, rightConstraint8, heightConstraint8])
        
        
    }
    
    @objc func updateAddressBar(){
        let address = DataManager.sharedInstance.logedUser.selectedAddress
        
        if address.street == ""{
            botAdrBarLeftLbl.text = LanguageManager.sharedInstance.getStringForKey(key: "add_address")
        }else{
            botAdrBarLeftLbl.text = address.street
        }
    }
    
    @objc func orderSentNotification(){
        self.selectedIndex = 2
        botBar.selectedItem = botBar.items[1]
        
    }
    
    @objc func deselectSearch(){
        self.searchBtn.isSelected = false
        self.searchBtn.tintColor = .black
    }
    
    @objc func addressBarAction(){
        let vc =  UIStoryboard(name: "Address", bundle: nil).instantiateViewController(withIdentifier: "AddressesListViewController") as! AddressesListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func openNotificationUserInfo(notification:NSNotification){
        guard let userInfo = UserDefaults.standard.dictionary(forKey: "lastUserInfo") else{
            return
        }
        
        guard let objectStr = userInfo["object"] as? String else{
            return
        }
        
        if let data = objectStr.data(using: .utf8) {
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                
                let delivery = DeliveryModel(dict: json ?? [:])
                
                
                let vc =  UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "TrackingDeliveryViewController") as! TrackingDeliveryViewController
                vc.order = delivery.order
                vc.deliveryObject = delivery
                self.navigationController?.pushViewController(vc, animated: true)
                
            }catch {
                
            }
            
        }
        
    }
    
    @objc func pushNotificationReceived(notification:NSNotification){
        
        if let userInfo = notification.userInfo as NSDictionary?{
            
            print(userInfo)
            guard let action = userInfo["action"] as? String else{
                return
            }
            
            guard let objectStr = userInfo["object"] as? String else{
                return
            }

            if let data = objectStr.data(using: .utf8) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                    
                    let delivery = DeliveryModel(dict: json ?? [:])
                    
                    switch action {
                    case "newLocation":
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "driverLocationUpdated"), object: json)
                        
                        return
                        
                    default:
                        presentNotificationBanner(deliveryObject: delivery)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "orderUpdated"), object: delivery)
                        
                        return
                    }
                    
                    
                    
                } catch {
                    print("Something went wrong")
                }
            }
        }
        
    }
    
    func presentNotificationBanner(deliveryObject: DeliveryModel){
        
        if true {
            
            var attributes = EKAttributes.topFloat
            attributes.entryBackground = .color(color: EKColor(light: .white, dark: .white))
            attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
            attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .init(width: 1, height: 1)))
            attributes.statusBar = .dark
            attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
            attributes.positionConstraints.maxSize = .init(width: .intrinsic, height: .intrinsic)
            attributes.displayDuration = 4
            
            let action = {
                
                if !(self.navigationController?.viewControllers.last?.isKind(of: TrackingDeliveryViewController.self) ?? false) {
                    let vc =  UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "TrackingDeliveryViewController") as! TrackingDeliveryViewController
                    vc.order = deliveryObject.order
                    vc.deliveryObject = deliveryObject
                    self.navigationController?.pushViewController(vc, animated: true)

                }
                
            }
            
            attributes.entryInteraction.customTapActions.append(action)
            
            let title = EKProperty.LabelContent(text: deliveryObject.order.restaurant.name, style: .init(font: UIFont.systemFont(ofSize: 15, weight: .semibold), color: EKColor(light: .black, dark: .black)))
            let description = EKProperty.LabelContent(text: deliveryObject.order.getStatusString(), style: .init(font: UIFont.systemFont(ofSize: 14, weight: .medium), color: EKColor(light: .darkGray, dark: .darkGray)))
            
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            imageView.image = UIImage(named: "flat_logo")!
            let renderer = UIGraphicsImageRenderer(size: imageView.bounds.size)
            let newImage = renderer.image { ctx in
                imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
            }
            
            let image = EKProperty.ImageContent(image: newImage, size: CGSize(width: 40, height: 40))
            
            let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
            let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
            
            let contentView = EKNotificationMessageView(with: notificationMessage)
            
            SwiftEntryKit.display(entry: contentView, using: attributes)
            
            
        }
    }

    
    //MARK: - Buttons Actions

    @objc func filterBtnAction(){
        let vc =  UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        self.view.addTopTransition()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func sortBtnAction(){
        let vc =  UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "SortByViewController") as! SortByViewController
        self.view.addTopTransition()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func searchBtnAction(){
        searchBtn.isSelected = !searchBtn.isSelected
        
        searchBtn.tintColor = searchBtn.isSelected ? .mangoGreen : .black
        
        NotificationCenter.default.post(name: NSNotification.Name("searchBarAction"), object: nil)
    }
    
    @objc func notificationsBtnAction(){
        let vc =  UIStoryboard(name: "RestaurantsList", bundle: nil).instantiateViewController(withIdentifier: "NotificationListViewController") as! NotificationListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Bottom Bar Delegate
    
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        
        if(self.selectedIndex == item.tag){
            return
        }
        
        sortBtn.isHidden = item.tag != 1
        filterBtn.isHidden = item.tag != 1
        notificationsBtn.isHidden = item.tag != 1
        searchBtn.isHidden = item.tag != 1
        botAddresBar.isHidden = item.tag == 2
        
        self.view.addTransition()
        self.selectedIndex = item.tag
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
    
}
