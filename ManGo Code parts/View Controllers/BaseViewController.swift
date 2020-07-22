//
//  BaseViewController.swift
//  JobDeal
//
//  Created by Priba on 12/7/18.
//  Copyright © 2018 Priba. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
import IHProgressHUD
import MaterialComponents

class BaseViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {

    var page = 0
    var isEndOfList = false
    var isLoading = false
    
    var rightBtn = UIButton()
    
    //##Material components floating array. Every property setup for MDCTextFiels must be stored localy in ViewController array. This is helper array for that purpose.
    var arrayOftextFieldControllerFloating = [MDCTextInputControllerFilled]()
    var arrayOftextFieldControllerUnderline = [MDCTextInputControllerUnderline]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        setupUI()
        setupStrings()
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(presentSplashLoader), name: Notification.Name(rawValue: "presentSplashLoader"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissSplashLoader), name: Notification.Name(rawValue: "dismissSplashLoader"), object: nil)
        
        var style = ToastStyle()
        style.messageColor = UIColor.black
        style.messageFont = UIFont.init(name: "Futura-Medium", size: 16)!
        style.backgroundColor = UIColor.separatorColor
        style.cornerRadius = 12
        
        
        ToastManager.shared.style = style
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    //MARK: - Private Methods
    func setupUI(){
    }
    
    func setupStrings(){
    }
    
    func loadData(){
    }
    
    func addNavigationBarWithTitle(title:String, rightButtonImage: UIImage = UIImage(), withShadow: Bool = true){
        
        let screenSize = UIApplication.shared.keyWindow?.frame.size
        let barHeight:CGFloat = 50.0
        let barColor = UIColor.white
        
        //NAV BAR
        let navBar = UIView(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: screenSize?.width ?? 300, height: barHeight))
        navBar.backgroundColor = barColor
        self.view.addSubview(navBar)
        
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
        
        //TITLE
        
        let titleLbl = UILabel()
        titleLbl.textAlignment = .center
        titleLbl.font = UIFont(name: "Futura-Medium", size: 18)!
        titleLbl.text = title.uppercased()
        navBar.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint2 = NSLayoutConstraint(item: titleLbl, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: navBar, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint2 = NSLayoutConstraint(item: titleLbl, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: navBar, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint2 = NSLayoutConstraint(item: titleLbl, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 160)
        let heightConstraint2 = NSLayoutConstraint(item: titleLbl, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 30)
        view.addConstraints([horizontalConstraint2, verticalConstraint2, widthConstraint2, heightConstraint2])
        
        
        //LeftBtn
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "backIcon")!, for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        navBar.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.tintColor = .black
        
        let topConstraint3 = NSLayoutConstraint(item: backBtn, attribute: .top, relatedBy: .equal, toItem: navBar, attribute: .top, multiplier: 1, constant: 0)
        let leftConstraint3 = NSLayoutConstraint(item: backBtn, attribute: .left, relatedBy: .equal, toItem: navBar, attribute: .left, multiplier: 1, constant: 8)
        let widthConstraint3 = NSLayoutConstraint(item: backBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        let heightConstraint3 = NSLayoutConstraint(item: backBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        navBar.addConstraints([topConstraint3, leftConstraint3, widthConstraint3, heightConstraint3])
        
        
        //RightBtn
        
        rightBtn = UIButton()
        rightBtn.setImage(rightButtonImage, for: .normal)
        rightBtn.addTarget(self, action: #selector(rightBtnAction), for: .touchUpInside)
        navBar.addSubview(rightBtn)
        rightBtn.translatesAutoresizingMaskIntoConstraints = false
        rightBtn.tintColor = .black
        let topConstraint4 = NSLayoutConstraint(item: rightBtn, attribute: .top, relatedBy: .equal, toItem: navBar, attribute: .top, multiplier: 1, constant: 0)
        let leftConstraint4 = NSLayoutConstraint(item: rightBtn, attribute: .right, relatedBy: .equal, toItem: navBar, attribute: .right, multiplier: 1, constant: -8)
        let widthConstraint4 = NSLayoutConstraint(item: rightBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        let heightConstraint4 = NSLayoutConstraint(item: rightBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: barHeight)
        navBar.addConstraints([topConstraint4, leftConstraint4, widthConstraint4, heightConstraint4])
        
        
        //SHADOW
        if withShadow{
            navBar.dropShadow3()
        }
    }

    func setupBackTapDissmisKeyboardGesture(){
        let backTap = UITapGestureRecognizer.init(target: self, action: #selector(dissmissKeyboardGestureAction))
        self.view.addGestureRecognizer(backTap)
        
    }
    
    @objc func dissmissKeyboardGestureAction() {
        self.view.endEditing(true)
    }
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightBtnAction() {

    }
    
    @objc func presentSplashLoader(){
        if(!(self.navigationController?.viewControllers.last?.isKind(of: SplashViewController.self) ?? false)){
            
            let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @objc func dismissSplashLoader(){
        if((self.navigationController?.viewControllers.last?.isKind(of: SplashViewController.self) ?? true)){
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    func presentLoader(){
        IHProgressHUD.set(defaultMaskType: .gradient)
        IHProgressHUD.set(defaultStyle: .dark)
        IHProgressHUD.set(ringThickness: 3)
        IHProgressHUD.set(foregroundColor: UIColor.mangoGreen)
        IHProgressHUD.show()
    }
    
    func dismissLoader(){
        IHProgressHUD.dismiss()
    }
    
    func popToCartWithNewOrder(order: OrderModel){
        for controller in self.navigationController?.viewControllers ?? [] {
            if controller.isKind(of: DashboardViewController.self){
                self.navigationController?.popToViewController(controller, animated: true)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "orderSentNotification"), object: order)
            }
        }
    }
    
    
    func popToResturantParent(){
        for controller in self.navigationController?.viewControllers ?? [] {
            if controller.isKind(of: ResturantParentViewController.self){
                self.navigationController?.popToViewController(controller, animated: true)
            }
        }
    }
    
    func popToDashboardParent(){
        for controller in self.navigationController?.viewControllers ?? [] {
            if controller.isKind(of: DashboardViewController.self){
                self.navigationController?.popToViewController(controller, animated: true)
            }
        }
    }
    
    
    //MARK: - KeyBoard Notifications
    @objc func keyboardWillChangeFrame(notification: NSNotification) {
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
    }
    
    //MARK: - GestureRecognizer Delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true;
    }
    
    //MARK: - TextField Delegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

}
