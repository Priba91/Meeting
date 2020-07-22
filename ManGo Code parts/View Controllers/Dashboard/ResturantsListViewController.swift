//
//  DashboardViewController.swift
//  ManGO
//
//  Created by Priba on 6/11/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import SideMenu
import MaterialComponents

class ResturantsListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var resturantsTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var resturantsArray = [ResturantModel]()
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var noSearchResultsLbl: UILabel!
    
    var loadResturantsByName = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuAnimationFadeStrength = 0.5
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "updateResturants"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resturantUpdated(notification:)), name: NSNotification.Name(rawValue: "resturantUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(searchBarNotification), name: NSNotification.Name(rawValue: "searchBarAction"), object: nil)

        let temp = CDManager.shared.fetchOrders()
        print("bla")
    }
    
    
    //MARK: Private Methods
    
    override func setupUI(){
                
        resturantsTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        resturantsTableView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor.mangoGreen
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        navBar.dropShadow3()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        resturantsTableView.estimatedRowHeight = 300
        resturantsTableView.rowHeight = UITableView.automaticDimension
        
        searchTextField.setHalfCornerRadius()
        searchTextField.placeholder = LanguageManager.sharedInstance.getStringForKey(key: "search")
        searchTextField.setLeftPaddingPoints(12)
        
        searchBarView.isHidden = true
        searchViewHeight.constant = 0
    }

    override func setupStrings(){
        titleLbl.setupTitleForKey(key: "mango")
        noSearchResultsLbl.setupTitleForKey(key: "no_restaurants_search_result")
    }
    
    @objc override func loadData() {
        //TODO: PAGING
        resturantsArray.removeAll()
        page = 0
        isEndOfList = false
        self.noSearchResultsLbl.isHidden = true
        
        if loadResturantsByName {
            
            ServerManager.sharedInstance.searchResturants(page: page, name: searchTextField.text ?? "", completition: { (response, success, errMsg) in
                self.refreshControl.endRefreshing()
                self.isLoading = false
                
                if success!{
                    
                    self.isEndOfList = response.count == 0
                    
                    if response.count == 0 && self.searchTextField.text?.count ?? 1 > 0 {
                        self.noSearchResultsLbl.isHidden = false
                    }
                    
                    for dict in response {
                        self.resturantsArray.append(ResturantModel(dict: dict))
                    }
                    self.resturantsTableView.reloadData()
                }else{
                    AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                        
                    })
                }
            })
        }else{
            
            ServerManager.sharedInstance.filterResturants(page: page) { (response, success, errMsg) in
                self.refreshControl.endRefreshing()
                self.isLoading = false

                if success!{
                    
                    self.isEndOfList = response.count == 0
                    
                    for dict in response {
                        self.resturantsArray.append(ResturantModel(dict: dict))
                    }
                    self.resturantsTableView.reloadData()
                }else{
                    AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                        
                    })
                }
            }
        }
    }
    
    func loadNextPage(){
        page += 1
        isLoading = true
        
        if loadResturantsByName {
            
            ServerManager.sharedInstance.searchResturants(page: page, name: searchTextField.text ?? "", completition: { (response, success, errMsg) in
                self.refreshControl.endRefreshing()
                self.isLoading = false

                if success!{
                    
                    self.isEndOfList = response.count == 0
                    
                    for dict in response {
                        self.resturantsArray.append(ResturantModel(dict: dict))
                    }
                    self.resturantsTableView.reloadData()
                }else{
                    self.page -= 1
                }
            })
        }else{
            
            ServerManager.sharedInstance.filterResturants(page: page) { (response, success, errMsg) in
                self.isLoading = false
                if success!{
                    self.isEndOfList = response.count == 0
                    
                    for dict in response {
                        self.resturantsArray.append(ResturantModel(dict: dict))
                    }
                    self.resturantsTableView.reloadData()
                }else{
                    self.page -= 1
                }
            }
        }
    }
    
    @objc func reloadData(){
        resturantsArray.removeAll()
        resturantsTableView.reloadData()
        
        loadData()
    }
    
    @objc func resturantUpdated(notification: Notification){
        guard let rest = notification.object as? ResturantModel else{
            return
        }
        
        guard let index = resturantsArray.firstIndex(where: {$0.id == rest.id}) as? Int else{
            return
        }
        
        resturantsArray[index] = rest
        resturantsTableView.reloadData()
    }
    
    //MARK: - Search Bar Actions
    
    @objc func searchBarNotification(){
        if searchViewHeight.constant == 0 {
            showSearchBar()
        }else{
            hideSearchBar()
        }
    }
    
    func showSearchBar(){
        searchBarView.isHidden = false
        searchViewHeight.constant = 54
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }) { (finished) in
            self.searchBarView.becomeFirstResponder()
        }
    }
    
    func hideSearchBar(){
        searchViewHeight.constant = 0
        self.view.endEditing(true)
        if loadResturantsByName{
            searchTextField.text = ""
            loadResturantsByName = false
            isEndOfList = false
            let indexPath = IndexPath(row: 0, section: 0)
            
            if resturantsTableView.visibleCells.count > 0 {
                resturantsTableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
            
            resturantsArray.removeAll()
            resturantsTableView.reloadData()
            loadData()
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }) { (finished) in
            self.searchBarView.isHidden = true
        }

    }
    
    //MARK: - TableView Data and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEndOfList ? resturantsArray.count : resturantsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row < resturantsArray.count{
            
            if indexPath.row == resturantsArray.count - 1 && !isEndOfList && !isLoading{
                loadNextPage()
            }
            
            let resturant = resturantsArray[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantTableViewCell", for: indexPath) as! ResturantTableViewCell
            
            cell.populate(resturant: resturant)
            cell.favoriteBtn.tag = indexPath.row
            cell.selectionBtn.tag = indexPath.row
            cell.selectionBtn.addTarget(self, action: #selector(self.selectBtnAction(_:)), for: .touchUpInside)
            cell.favoriteBtn.addTarget(self, action: #selector(self.addToFavoriteBtnAction(_:)), for: .touchUpInside)
            
            cell.contentView.isUserInteractionEnabled = true

            return cell
        }else if indexPath.row == resturantsArray.count && !isEndOfList{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpinerTableViewCell", for: indexPath) as! SpinerTableViewCell
            cell.spiner.startAnimating()
            return cell
        }
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < resturantsArray.count{
            return UITableView.automaticDimension
        }
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DidSelect")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !searchBarView.isHidden && searchTextField.text == "" {
            searchViewHeight.constant = 0
            loadResturantsByName = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deselectSearch"), object: nil)
            self.view.endEditing(true)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }) { (finished) in
                self.searchBarView.isHidden = true
            }
        }
    }
    
    //MARK: - Keyboard Notifications
    
    override func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            resturantsTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: keyboardHeight, right: 0)
            
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        resturantsTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    
    //MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            let indexPath = IndexPath(row: 0, section: 0)
            if resturantsArray.count > 0 {
                resturantsTableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }

            isEndOfList = false
            loadResturantsByName = true
            resturantsArray.removeAll()
            resturantsTableView.reloadData()
            loadData()
        }
        self.view.endEditing(true)
        return true
    }

    //MARK: - Buttons Action
    
    @objc func addToFavoriteBtnAction(_ sender: UIButton) {
        if sender.tag < resturantsArray.count {
            
            resturantsArray[sender.tag].isFavorite = !resturantsArray[sender.tag].isFavorite

            resturantsTableView.reloadData()
            ServerManager.sharedInstance.toggleFavorite(resturant: resturantsArray[sender.tag]) { (response, success, errMsg) in
                
            }
        }
    }
    
    @objc func selectBtnAction(_ sender: UIButton) {
        if sender.tag < resturantsArray.count {
            let vc =  UIStoryboard(name: "Restaurant", bundle: nil).instantiateViewController(withIdentifier: "ResturantParentViewController") as! ResturantParentViewController
            vc.resturant = resturantsArray[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}
