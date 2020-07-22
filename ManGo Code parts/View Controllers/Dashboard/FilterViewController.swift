//
//  FilterViewController.swift
//  ManGO
//
//  Created by Priba on 6/14/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents

class FilterViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    var foodTypesArray = [FoodType]()
    var tagsArray = [TagModel]()
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var tagsTableView: UITableView!
    
    @IBOutlet weak var separatorView: MDCCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        self.addNavigationBarWithTitle(title: LanguageManager.sharedInstance.getStringForKey(key: "filters"), rightButtonImage: UIImage(named: "reset")!)
        separatorView.setShadowElevation(.init(4), for: .normal)
        separatorView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        separatorView.layer.cornerRadius = 16
        
        filterTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    override func setupStrings() {
        searchBtn.setupTitleForKey(key: "search", uppercased: true)
    }
    
    override func loadData() {
        foodTypesArray = DataManager.sharedInstance.foodTypes.clone()
        tagsArray = [TagModel(nameKey: "gratis_food"), TagModel(nameKey: "promo_codes"), TagModel(nameKey: "currently_open")]
        
        foodTypesArray.setSelected(savedArray: DataManager.sharedInstance.mainFilter.foodTypes)

        filterTableView.reloadData()
        
    }
    
    //MARK: - Buttons Action
    
    override func backBtnAction() {
        self.view.addBottomTransition()
        self.navigationController?.popViewController(animated: false)
    }
    
    override func rightBtnAction() {
        AJAlertController.initialization().showAlert(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "reset_settings"), aStrMessage: LanguageManager.sharedInstance.getStringForKey(key: "reset_settings_desc"), aCancelBtnTitle: LanguageManager.sharedInstance.getStringForKey(key: "dont_reset"), aOtherBtnTitle: LanguageManager.sharedInstance.getStringForKey(key: "reset")) { (index, errMsg) in
            if index == 1 {
                DataManager.sharedInstance.mainFilter = FilterModel.init()
                self.tagsArray.forEach({ (tmp) in
                    tmp.selected = false
                })
                self.loadData()
                
            }
        }
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        
        DataManager.sharedInstance.mainFilter.foodTypes = foodTypesArray.cloneSelected()
        DataManager.sharedInstance.mainFilter.saveMainFilterToUserDefaults()
        
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateResturants"), object: nil)
    }
    
    //MARK: - TableView Data and Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == filterTableView {
            return foodTypesArray.count
        }else{
            return tagsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == filterTableView {
            if indexPath.row < foodTypesArray.count{
                let tmp = foodTypesArray[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: "RadioTableViewCell", for: indexPath) as! RadioTableViewCell
                cell.nameLbl.text = tmp.name
                cell.setMultiSelected(selected: tmp.selected)
                
                return cell
            }
        }else{
            if indexPath.row < tagsArray.count{
                let tmp = tagsArray[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckTableViewCell", for: indexPath) as! CheckTableViewCell
                cell.nameLbl.text = tmp.name
                cell.setSelected(selected: tmp.selected)
                
                return cell
            }
        }
        
        return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == filterTableView {
            if indexPath.row < foodTypesArray.count{
                foodTypesArray[indexPath.row].selected = !foodTypesArray[indexPath.row].selected
                filterTableView.reloadData()
            }
        }else{
            if indexPath.row < tagsArray.count{
                tagsArray[indexPath.row].selected = !tagsArray[indexPath.row].selected
                tagsTableView.reloadData()
            }
        }
        
    }
    
}
