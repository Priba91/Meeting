//
//  TrackingDeliveryViewController.swift
//  ManGO
//
//  Created by Priba on 8/15/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import GoogleMaps
import SDWebImage

class TrackingDeliveryViewController: BaseViewController {

    @IBOutlet weak var resturantImageView: UIImageView!
    @IBOutlet weak var resturantNameLbl: UILabel!
    @IBOutlet weak var foodTypeLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var paymentLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var rateSmallIcon: UIButton!
    @IBOutlet weak var rateLbl: UILabel!
    
    @IBOutlet weak var headerShadowView: MDCCard!

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var footerShadowView: MDCCard!
    @IBOutlet weak var simpleStatusView: UIView!
    @IBOutlet weak var hourglassIcon: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateViewBotConstraint: NSLayoutConstraint!
    @IBOutlet weak var rateTitleLbl: UILabel!
    
    @IBOutlet weak var fiveRateBtn: UIButton!
    @IBOutlet weak var fourRateBtn: UIButton!
    @IBOutlet weak var threeRateBtn: UIButton!
    @IBOutlet weak var twoRateBtn: UIButton!
    @IBOutlet weak var oneRateBtn: UIButton!
    @IBOutlet weak var sendRateBtn: UIButton!
    @IBOutlet weak var commentTextView: MDCTextField!
    
    @IBOutlet weak var driverView: UIView!
    @IBOutlet weak var driverAvatar: UIImageView!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var carColorLbl: UILabel!
    @IBOutlet weak var carTypeLbl: UILabel!
    @IBOutlet weak var deliveryPriceBtn: UIButton!
    @IBOutlet weak var driverAvgRateBtn: UIButton!
    @IBOutlet weak var deliveryEstimatedDuration: UILabel!
    
    @IBOutlet weak var driverLoadingView: UIView!
    @IBOutlet weak var driverLoadingSpinner: UIActivityIndicatorView!
    
    var rotatingAnimationTimer = Timer()
    var order = OrderModel()
    var deliveryObject = DeliveryModel()

    var driverMarker = GMSMarker()
    
    var ratingGrade = 0
    
    override func viewDidLoad() {
        populateData()
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(recievedPushNotification(notification:)), name: Notification.Name(rawValue: "orderUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(driverLocationUpdated(notification:)), name: Notification.Name(rawValue: "driverLocationUpdated"), object: nil)

    }
    

    // MARK: - Super Methods
    
    override func setupUI() {
        
        mapView.setMinZoom(0, maxZoom: 18)
        mapView.animate(toZoom: 13)
        mapView.padding = UIEdgeInsets(top: 16, left: 0, bottom: 128, right: 0)

        headerShadowView.setShadowElevation(ShadowElevation.init(rawValue: 6), for: .normal)
        footerShadowView.setShadowElevation(ShadowElevation.init(rawValue: 6), for: .normal)
        
        footerShadowView.cornerRadius = 8
        simpleStatusView.layer.cornerRadius = 8
        driverView.layer.cornerRadius = 8

        hourglassIcon.tintColor = .black
        
        arrayOftextFieldControllerFloating.append(commentTextView.setupInitState(placeholderKey: "leave_comment", returnKeyType: .done))
        commentTextView.addGrayBorderStroke()
        
        rateTitleLbl.setupTitleForKey(key: "rate_the_restaurant")
        sendRateBtn.setupTitleForKey(key: "rate", uppercased: true)
        
        driverLoadingSpinner.startAnimating()
        
    }
    
    override func setupStrings() {
        
    }
    
    override func loadData() {
        driverLoadingView.isHidden = false
        ServerManager.sharedInstance.getDeliveryById(id: order.id) { (response, success, err) in
            if success! {
                
                self.deliveryObject = DeliveryModel(dict: response)
                self.order.status = self.deliveryObject.order.status
                self.populateData()
            }
        }
    }
    
    func populateData(){
        resturantImageView.sd_setImage(with: URL(string: order.restaurant.imageUrl), placeholderImage: UIImage(named: "resturant_placeholder"), options: .refreshCached, completed: nil)
        resturantNameLbl.text = order.restaurant.name
        foodTypeLbl.text = order.restaurant.foodType
        favoriteBtn.tintColor = order.restaurant.isFavorite ? UIColor.mangoGreen : UIColor.lightGray
        
        paymentLbl.text = "\(order.restaurant.minDeliveryPrice)"
        rateLbl.text = "\(order.restaurant.averageRate)/\(order.restaurant.numberOfRates)"
        timeLbl.text = "\(order.restaurant.openTime) - \(order.restaurant.closeTime)"
        
        if order.restaurant.averageRate < 2.5 {
            rateSmallIcon.tintColor = .lightGray
        }
        
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
        
        resturantImageView.sd_setImage(with: URL(string: order.restaurant.imageUrl), placeholderImage: UIImage(named: "resturant_placeholder"), options: .refreshCached, completed: nil)
        driverNameLbl.text = "\(deliveryObject.driver.firstName) \(deliveryObject.driver.lastName)"
        carColorLbl.text = deliveryObject.driver.carColor
        carTypeLbl.text = deliveryObject.driver.carType
        deliveryPriceBtn.setTitle("\(String.init(format: "%2.f", deliveryObject.deliveryPrice)) \(DataManager.sharedInstance.currency)", for: .normal)
        driverAvgRateBtn.setTitle("\(deliveryObject.driver.avgRate)", for: .normal)
        deliveryEstimatedDuration.text = "\(LanguageManager.sharedInstance.getStringForKey(key: "estimated_delivery_time")): \(deliveryObject.duration)"
        
        driverLoadingView.isHidden = deliveryObject.driver.id != 0
        
        if deliveryObject.arrayOfCoordinates.count != 0 {
            let path = GMSMutablePath()
            self.deliveryObject.arrayOfCoordinates.forEach {
                path.add($0)
            }
            
            let pathLine = GMSPolyline.init(path: path)
            pathLine.strokeColor = .blue
            pathLine.strokeWidth = 3
            pathLine.map = self.mapView
        }
        
        if deliveryObject.driver.id != 0 {
            let markerImage3 = UIImage(named: "icDriverMovingTagCopy")!
            let markerView3 = UIImageView(image: markerImage3)
            driverMarker.position = CLLocationCoordinate2D(latitude: deliveryObject.driver.lat, longitude: deliveryObject.driver.lng)
            markerView3.contentMode = .bottom
            driverMarker.iconView = markerView3
            driverMarker.map = mapView
        }
        
        //Bottom Views
        rateView.isHidden = true
        simpleStatusView.isHidden = true
        driverView.isHidden = true
        
        self.addNavigationBarWithTitle(title: LanguageManager.sharedInstance.getStringForKey(key: "order_tracking"), withShadow: false)
        
        if (order.status == .Delivered || order.status == .PickedUp) && order.rateable {
            
            self.addNavigationBarWithTitle(title: LanguageManager.sharedInstance.getStringForKey(key: "rate_restaurant"), withShadow: false)
        }
        
        switch order.status{
        case .UserOrdered, .DriverDeclined, .SentRequestDriver:
            simpleStatusView.isHidden = false
            statusLbl.text = order.getStatusString()
            
            hourglassIcon.rotate()
            rotatingAnimationTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(glassRotationAction), userInfo: nil, repeats: true)
            
            break
            
        case .RestaurantAccepted:
            simpleStatusView.isHidden = false
            statusLbl.text = order.getStatusString()
            break
            
        case .RestaurantDeclined, .Cancelled:
            simpleStatusView.isHidden = false
            statusLbl.text = order.getStatusString()
            rotatingAnimationTimer.invalidate()
            hourglassIcon.image = UIImage(named: "declined")
            
            break
            
        case .DriverAccepted, .DriverStartedDelivery, .PickedUp, .DriverArrived:
            driverView.isHidden = false
            populateDriverView()
            
        case .Delivered, .Expired:
            self.addNavigationBarWithTitle(title: LanguageManager.sharedInstance.getStringForKey(key: "rate_restaurant"), withShadow: false)
            
            if order.rateable {
                rateView.isHidden = false
            }
        }
    }
    
    @objc func glassRotationAction(){
        hourglassIcon.rotate()
    }

    func deselectRatingButtons() {
        oneRateBtn.isSelected = false
        twoRateBtn.isSelected = false
        threeRateBtn.isSelected = false
        fourRateBtn.isSelected = false
        fiveRateBtn.isSelected = false
    }
    
    @objc func recievedPushNotification(notification: NSNotification){
        guard let deliveryObj = notification.object as? DeliveryModel else{
            loadData()
            return
        }
        let driver = self.deliveryObject.driver
        self.deliveryObject = deliveryObj
        self.deliveryObject.driver = driver
        self.order.status = deliveryObject.order.status
        loadData()
        self.populateData()
        
    }
    
    @objc func driverLocationUpdated(notification: NSNotification){
        guard let userInfo = notification.object as? NSDictionary else{
            return
        }

        let lat: Double = userInfo["lat"] as? Double ?? 0
        let lng: Double = userInfo["lng"] as? Double ?? 0
        let degree: Double = userInfo["degree"] as? Double ?? 0

        driverMarker.position = CLLocationCoordinate2DMake(lat, lng)
        driverMarker.rotation = degree
        
    }
    
    //MARK: - Private Methods
    func populateDriverView(){
        //GET Delivery by id
    }
    
    //MARK: - ButtonsActions
    @IBAction func oneRateBtnAction(_ sender: Any) {
        ratingGrade = 1
        deselectRatingButtons()
        oneRateBtn.isSelected = true
    }
    
    @IBAction func twoRateBtnAction(_ sender: Any) {
        ratingGrade = 2
        deselectRatingButtons()
        twoRateBtn.isSelected = true
    }
    
    @IBAction func threeRateBtnAction(_ sender: Any) {
        ratingGrade = 3
        deselectRatingButtons()
        threeRateBtn.isSelected = true
    }
    
    @IBAction func fourRateBtnAction(_ sender: Any) {
        ratingGrade = 4
        deselectRatingButtons()
        fourRateBtn.isSelected = true
    }
    
    @IBAction func fiveRateBtnAction(_ sender: Any) {
        ratingGrade = 5
        deselectRatingButtons()
        fiveRateBtn.isSelected = true
    }
    
    @IBAction func sendRateBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        self.presentLoader()
        
        if ratingGrade == 0 {
            AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: LanguageManager.sharedInstance.getStringForKey(key: "leave_rate_warning"), completion: { (index, str) in
                
            })
            return
        }
        
        ServerManager.sharedInstance.addResturantRate(order: order, rate: ratingGrade, comment: commentTextView.text ?? "") { (response, success, errMsg) in
            self.dismissLoader()
            if success!{
                self.navigationController?.popViewController(animated: true)
            }else{
                AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                    
                })
                
            }
        }
    }
    
    //MARK: - Keyboard Notifications
    
    override func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            UIView.animate(withDuration: 0.3) {
                self.rateViewBotConstraint.constant = -keyboardHeight
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.rateViewBotConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = 0
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
