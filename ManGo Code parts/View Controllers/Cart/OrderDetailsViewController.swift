//
//  OrderDetailsViewController.swift
//  ManGO
//
//  Created by Priba on 8/13/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import GoogleMaps
import SDWebImage

class OrderDetailsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, GMSMapViewDelegate, AddressListDelegate, DeliveryPhoneCellDelegate, UITextViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var separatorView: MDCCard!
    
    @IBOutlet weak var resturantImageView: UIImageView!
    @IBOutlet weak var resturantNameLbl: UILabel!
    @IBOutlet weak var foodTypeLbl: UILabel!
    @IBOutlet weak var rateSmallIcon: UIButton!
    @IBOutlet weak var rateLbl: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var iPickLbl: UILabel!
    @IBOutlet weak var iPickSwitch: UISwitch!
        
    @IBOutlet weak var subtotalTitleLbl: UILabel!
    @IBOutlet weak var subtotalLbl: UILabel!
    
    @IBOutlet weak var deliveryPriceFooterLbl: UILabel!
    @IBOutlet weak var deliveryAddressFooterLbl: UILabel!
    @IBOutlet weak var deliveryPriceFooterValueLbl: UILabel!
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var checkoutBtn: UIButton!
        
    var wantDelivery = true
    
    var order = OrderModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(newPaymentMethodChoosed), name: NSNotification.Name(rawValue: "newPaymentMethodsChoosed"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addedNewCard), name: NSNotification.Name(rawValue: "addedNewCard"), object: nil)

    }
    
    @objc func newPaymentMethodChoosed(){
        loadData()
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addedNewCard(){
        let vc =  UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "ChoosePaymentMethodViewController") as! ChoosePaymentMethodViewController
        vc.parentNavigationController = self.navigationController
        self.present(vc, animated: false, completion: nil)
    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        self.addNavigationBarWithTitle(title: LanguageManager.sharedInstance.getStringForKey(key: "delivery_details"), withShadow: false)
        separatorView.setShadowElevation(.init(3), for: .normal)
        separatorView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        separatorView.layer.cornerRadius = 16
        
        mapView.setMinZoom(0, maxZoom: 18)
        mapView.animate(toZoom: 13)
        mapView.padding = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        
        resturantImageView.layer.cornerRadius = 8

    }
    
    override func setupStrings() {
        totalLbl.setupTitleForKey(key: "total")
        checkoutBtn.setupTitleForKey(key: "order", uppercased: true)
        
        iPickLbl.setupTitleForKey(key: "i_will_pick_it")
        
        subtotalTitleLbl.setupTitleForKey(key: "item_subtotal")
        deliveryPriceFooterLbl.setupTitleForKey(key: "delivery")
        
    }
    
    override func loadData() {
        
        resturantImageView.sd_setImage(with: URL(string: order.restaurant.imageUrl), placeholderImage: UIImage(named: "resturant_placeholder"), options: .refreshCached, completed: nil)
        resturantNameLbl.text = order.restaurant.name
        rateLbl.text = "\(order.restaurant.averageRate) (\(order.restaurant.numberOfRates))"
        rateSmallIcon.tintColor = order.restaurant.numberOfRates > 0 ? .mangoGreen : .lightGray
        
        let typeStr = NSMutableAttributedString(string: "$$$$ \(order.restaurant.foodType)")
        
        var myRange = NSRange(location: 0, length: order.restaurant.priceRange)
        typeStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mangoGreen, range: myRange)
        myRange = NSRange(location: order.restaurant.priceRange, length: 4 - order.restaurant.priceRange)
        typeStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray.withAlphaComponent(0.7), range: myRange)

        foodTypeLbl.attributedText = typeStr

        mapView.clear()
        
        let addressMarker = GMSMarker()
        let markerImage = UIImage(named: "map_pin")!.withRenderingMode(.alwaysTemplate)
        let markerView = UIImageView(image: markerImage)
        markerView.tintColor = UIColor.mangoGreen
        addressMarker.position = CLLocationCoordinate2D(latitude: order.address.lat, longitude: order.address.lng)
        addressMarker.iconView = markerView
        addressMarker.map = mapView
        
        let restaurantMarker = GMSMarker()
        let markerImage2 = UIImage(named: "map_pin")!.withRenderingMode(.alwaysTemplate)
        let markerView2 = UIImageView(image: markerImage2)
        markerView2.tintColor = UIColor.black
        restaurantMarker.position = CLLocationCoordinate2D(latitude: order.restaurant.address.lat, longitude: order.restaurant.address.lng)
        restaurantMarker.iconView = markerView2
        restaurantMarker.map = mapView
        
        let bounds = GMSCoordinateBounds(coordinate: addressMarker.position, coordinate: restaurantMarker.position)
        let camera: GMSCameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 30.0)
        self.mapView.animate(with: camera)
            
        updateFooterPrices()
    }
    
    private func updateFooterPrices(){
       
        subtotalLbl.text = Utils.getPriceString(price: order.calculateTotalPrice())
        deliveryAddressFooterLbl.text = order.address.street
        
        deliveryPriceFooterValueLbl.text = Utils.getPriceString(price: wantDelivery ? order.pricePrediction : 0)
        totalPriceLbl.text = Utils.getPriceString(price: order.calculateTotalPrice() + order.pricePrediction)

    }
    
    //MARK: - TableView Data and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wantDelivery ? 5 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if wantDelivery {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHeaderTableViewCell", for: indexPath) as! OrderHeaderTableViewCell
                cell.populate(strKey: "cargo_fresh_delivery")
                return cell

            }
            else if indexPath.row == 2{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHeaderTableViewCell", for: indexPath) as! OrderHeaderTableViewCell
                cell.populate(strKey: "payment")
                return cell
                
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryDetailTableViewCell", for: indexPath) as! DeliveryDetailTableViewCell
                cell.populateWith(order: order, row: indexPath.row)
                return cell
                
            }
        }else{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHeaderTableViewCell", for: indexPath) as! OrderHeaderTableViewCell
                cell.populate(strKey: "payment")
                return cell
                
            }
            else if indexPath.row == 1{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryDetailTableViewCell", for: indexPath) as! DeliveryDetailTableViewCell
                cell.populateWith(order: order, row: 3)
                return cell
                
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryDetailTableViewCell", for: indexPath) as! DeliveryDetailTableViewCell
                cell.populateWith(order: order, row: 4)
                return cell
                
            }
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = wantDelivery ? indexPath.row : indexPath.row + 3

        switch index {
        case 1:
            
            let vc =  UIStoryboard(name: "Address", bundle: nil).instantiateViewController(withIdentifier: "AddressesListViewController") as! AddressesListViewController
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc =  UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "ChoosePaymentMethodViewController") as! ChoosePaymentMethodViewController
            vc.parentNavigationController = self.navigationController
            self.present(vc, animated: true, completion: nil)

        case 4:
            let vc =  UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "PromoCodeViewController") as! PromoCodeViewController
            vc.parentNavigationController = self.navigationController
            self.present(vc, animated: true, completion: nil)

        default:
            break
        }
    }
    
    //Address List Delegate

    func didSelectAddress(address: AddressModel) {
        self.order.address = address

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
                
                self.loadData()
                self.tableView.reloadData()
                
                self.navigationController?.popViewController(animated: true)

            }else{
                AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                    
                })
            }
        }

    }
    
    //Phone Cell Delegate

    func didUpdatePhoneNumber(number: String) {
        order.address.phone = number
        tableView.reloadData()
    }
    
    //MARK: - Buttons Actions
    
    @IBAction func checkoutBtnAction(_ sender: Any) {
        self.presentLoader()
        ServerManager.sharedInstance.makeOrder(order: order, withDelivery: wantDelivery) { (response, success, errMsg) in
            self.dismissLoader()
            if success!{
                CDManager.shared.removeOrderWithResturant(resturant: self.order.restaurant)
                self.order = OrderModel(dict: response)
                print("ORDERID: \(self.order.id)")
                self.popToCartWithNewOrder(order: self.order)
                
            }else{
                AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                    
                })
            }
        }
        
    }

    //Switchs action
    @IBAction func switchAction(_ sender: UISwitch) {
        wantDelivery = !sender.isOn
        self.view.addTransition()
        updateFooterPrices()
        tableView.reloadData()
    }
    
}

