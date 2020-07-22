//
//  CartViewController.swift
//  ManGO
//
//  Created by Priba on 7/26/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class CartViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartIsEmptyLbl: UILabel!
    
    var ordersArray = [OrderModel]()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(orderSentNotification(notification:)), name: Notification.Name(rawValue: "orderSentNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(recievedPushNotification(notification:)), name: Notification.Name(rawValue: "orderUpdated"), object: nil)

    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        navBar.dropShadow3()

        tableView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor.mangoGreen
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    override func setupStrings() {
        cartIsEmptyLbl.setupTitleForKey(key: "empty_cart")
    }
    
    @objc override func loadData() {
        page = 0
        isEndOfList = false
        
        self.ordersArray.removeAll()
        self.tableView.reloadData()

        ServerManager.sharedInstance.getHistoryOfOrders(page: page) { (response, success, errMsg) in
            self.refreshControl.endRefreshing()

            if success! {
                if response.count == 0 {
                    self.isEndOfList = true
                }
                
                self.ordersArray.removeAll()
                for dict in response {
                    let order = OrderModel(dict: dict)
                    self.ordersArray.append(order)
                }
                self.cartIsEmptyLbl.isHidden = self.ordersArray.count != 0
                self.tableView.reloadData()
                
            }else{
                AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                    
                })
            }
        }
    }
    
    func loadNextPage() {
        page += 1

        isLoading = true
        ServerManager.sharedInstance.getHistoryOfOrders(page: page) { (response, success, errMsg) in
            self.isLoading = false
            if success! {
                if response.count == 0 {
                    self.isEndOfList = true
                }
                
                for dict in response {
                    let order = OrderModel(dict: dict)
                    self.ordersArray.append(order)
                }
                self.tableView.reloadData()
                
            }else{
                self.page -= 1
            }
        }
    }

    @objc func orderSentNotification(notification: NSNotification){
        cartIsEmptyLbl.isHidden = true
        guard let order = notification.object as? OrderModel else{
            loadData()
            return
        }
        
        self.ordersArray.insert(order, at: 0)
        tableView.reloadData()
        
    }
    
    @objc func recievedPushNotification(notification: NSNotification){
        guard let deliveryObject = notification.object as? DeliveryModel else{
            loadData()
            return
        }
        
        guard let index = ordersArray.firstIndex(where: {$0.id == deliveryObject.order.id}) else{
            loadData()
            return
        }
        
        ordersArray[index].status = deliveryObject.order.status
        tableView.reloadData()
    }
    
    //MARK: - TableView Data and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEndOfList ? ordersArray.count : ordersArray.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == ordersArray.count && !isEndOfList && !isLoading {
            loadNextPage()
        }
        
        if indexPath.row < ordersArray.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartOrderTableViewCell", for: indexPath) as! CartOrderTableViewCell
            cell.populate(order: ordersArray[indexPath.row])
            cell.rightBtn.tag = indexPath.row
            cell.previewBtn.tag = indexPath.row
            
            return cell
        }else if indexPath.row == ordersArray.count && !isEndOfList{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpinerTableViewCell", for: indexPath) as! SpinerTableViewCell
            cell.spiner.startAnimating()
            
            return cell
        }
        
        return UITableViewCell()

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }

    //Buttons Actions
    
    @IBAction func mapBtnAction(sender: UIButton){
        if sender.tag < ordersArray.count {
            let order = ordersArray[sender.tag]
            
            switch order.status{
            case .UserOrdered, .RestaurantAccepted, .DriverAccepted, .DriverDeclined, .DriverStartedDelivery, .SentRequestDriver, .PickedUp:
                let vc =  UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "TrackingDeliveryViewController") as! TrackingDeliveryViewController
                vc.order = ordersArray[sender.tag]
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .Delivered:
                if order.rateable {
                    let vc =  UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "TrackingDeliveryViewController") as! TrackingDeliveryViewController
                    vc.order = ordersArray[sender.tag]
                    self.navigationController?.pushViewController(vc, animated: true)
                }

            case .DriverArrived:
                let vc =  UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "QRConfirmationViewController") as! QRConfirmationViewController
                vc.order = ordersArray[sender.tag]
                self.navigationController?.pushViewController(vc, animated: true)
            case .Expired, .Cancelled, .RestaurantDeclined:
                let vc =  UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "ResturantOrderViewController") as! ResturantOrderViewController
                vc.order = ordersArray[sender.tag]
                vc.fromCart = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func previewOrderBtnAction(sender: UIButton){
        if sender.tag < ordersArray.count {
            let vc =  UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "ResturantOrderViewController") as! ResturantOrderViewController
            vc.order = ordersArray[sender.tag]
            vc.fromCart = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
