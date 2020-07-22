//
//  ResturantOrderViewController.swift
//  ManGO
//
//  Created by Priba on 8/12/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import IHProgressHUD
import RSKGrowingTextView

class ResturantOrderViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var separatorView: MDCCard!

    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var checkoutBtn: UIButton!
    @IBOutlet weak var botConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkoutBtnHeight: NSLayoutConstraint!
    
    @IBOutlet weak var resturantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLbl: UILabel!
    @IBOutlet weak var restaurantTypeLbl: UILabel!
    @IBOutlet weak var restaurantRateIcon: UIButton!
    @IBOutlet weak var restaurantRateLbl: UILabel!
    
    var fromCart = false
    var isNoteTFEnabled = true
    var order = OrderModel()
    var showMinDeliveryAlert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        order.address = DataManager.sharedInstance.logedUser.selectedAddress
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard), name: NSNotification.Name(rawValue: "closeKeyboard"), object: nil)
    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        self.addNavigationBarWithTitle(title: LanguageManager.sharedInstance.getStringForKey(key: "cart"), withShadow: false)
        separatorView.setShadowElevation(.init(3), for: .normal)
        separatorView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        separatorView.layer.cornerRadius = 16
        
        if fromCart {
            if order.status != .Cancelled && order.status != .Expired && order.status != .RestaurantDeclined {
                checkoutBtnHeight.constant = 0
                checkoutBtn.isEnabled = false
                isNoteTFEnabled = false

            }
        }
        
        resturantImageView.layer.cornerRadius = 8
        
        self.rightBtn.setImage(UIImage(named: "icDelete"), for: .normal)
    }
    
    override func setupStrings() {
        totalLbl.setupTitleForKey(key: "total")
        checkoutBtn.setupTitleForKey(key: "begin_checkout", uppercased: true)
    }
    
    override func loadData() {
        totalPriceLbl.text = Utils.getPriceString(price: order.calculateTotalPrice())
        
        showMinDeliveryAlert = false
        if order.calculateTotalPrice() < order.restaurant.minDeliveryPrice {
            showMinDeliveryAlert = true
        }
        
        resturantImageView.sd_setImage(with: URL(string: order.restaurant.imageUrl), placeholderImage: UIImage(named: "resturant_placeholder"), options: .refreshCached, completed: nil)
        restaurantNameLbl.text = order.restaurant.name
        restaurantRateLbl.text = "\(order.restaurant.averageRate) (\(order.restaurant.numberOfRates))"
        restaurantRateIcon.tintColor = order.restaurant.numberOfRates > 0 ? .mangoGreen : .lightGray
        
        let typeStr = NSMutableAttributedString(string: "$$$$ \(order.restaurant.foodType)")
        
        var myRange = NSRange(location: 0, length: order.restaurant.priceRange)
        typeStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mangoGreen, range: myRange)
        myRange = NSRange(location: order.restaurant.priceRange, length: 4 - order.restaurant.priceRange)
        typeStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray.withAlphaComponent(0.7), range: myRange)

        restaurantTypeLbl.attributedText = typeStr
    }

    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
    
    override func rightBtnAction() {
        AJAlertController.initialization().showAlert(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "delete_order"), aStrMessage: LanguageManager.sharedInstance.getStringForKey(key: "delete_order_atention"), aCancelBtnTitle: LanguageManager.sharedInstance.getStringForKey(key: "cancel"), aOtherBtnTitle: LanguageManager.sharedInstance.getStringForKey(key: "delete")) { (index, str) in
            
            if index == 1 {
                CDManager.shared.removeOrderWithResturant(resturant: self.order.restaurant)
                self.popToResturantParent()
            }
        }
        
    }
    
    //MARK: - TableView Data and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.menuItems.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderNoteTableViewCell", for: indexPath) as! OrderNoteTableViewCell
            cell.noteTextView.delegate = self
            cell.noteTextView.isUserInteractionEnabled = isNoteTFEnabled
            return cell
  
        }else if indexPath.row == 1{

            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHeaderTableViewCell", for: indexPath) as! OrderHeaderTableViewCell
            cell.populate(strKey: "order_items")
            return cell
            
        }else if indexPath.row - 2 < order.menuItems.count {
 
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemTableViewCell", for: indexPath) as! OrderItemTableViewCell
            cell.populateWith(item: order.menuItems[indexPath.row - 2])
            cell.deleteBtn.tag = indexPath.row - 2
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    //Buttons Actions
    
    @IBAction func checkoutBtnAction(_ sender: Any) {
        self.presentLoader()
        ServerManager.sharedInstance.getPredictedValues(address: order.address, resturant: order.restaurant) { (response, success, errMsg) in
            self.dismissLoader()
            if success!{
                
                if let temp = response["pricePrediction"] as? Double {
                    self.order.pricePrediction = temp
                }
                
                if let temp = response["distance"] as? Int {
                    self.order.distance = temp
                }

                let vc =  UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
                vc.order = self.order
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                    
                })
            }
        }
    }

    //MARK: - TextField Delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: - Buttons Actions

    @IBAction func addMoreBtnAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMoreRestaurantNotification"), object: nil)
    }
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
        
        if sender.tag < order.menuItems.count {
            if order.menuItems.count == 1 {
                rightBtnAction()
            }else{
                order.menuItems.remove(at: sender.tag)
                CDManager.shared.updateOrder(order: order)
                self.tableView.reloadData()
            }
        }
        
    }
    
    //MARK: - Keyboard Notifications

    override func keyboardWillChangeFrame(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            botConstraint.constant = keyboardHeight
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        botConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
}
