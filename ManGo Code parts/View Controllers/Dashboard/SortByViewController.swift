//
//  SortByViewController.swift
//  ManGO
//
//  Created by Priba on 6/13/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class SortByViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    var sortArray = [SortModel]()
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var sortTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        self.addNavigationBarWithTitle(title: LanguageManager.sharedInstance.getStringForKey(key: "sort_by"))
    }
    
    override func setupStrings() {
        searchBtn.setupTitleForKey(key: "search", uppercased: true)
    }
    
    override func loadData() {
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "sort_by_fresh")))
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "my_favorite")))
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "popular")))
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "new")))
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "rate")))
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "rate_count")))
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "cheepest")))
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "most_expensive")))
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "nearest")))
        sortArray.append(SortModel(name:LanguageManager.sharedInstance.getStringForKey(key: "farest")))
        
        sortArray.loadSelected()
        sortTableView.reloadData()
    }
    
    //MARK: - Buttons Action
    
    override func backBtnAction() {
        self.view.addBottomTransition()
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        sortArray.saveSelected()
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateResturants"), object: nil)
    }
    
    //MARK: - TableView Data and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row < sortArray.count{
            let tmp = sortArray[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RadioTableViewCell", for: indexPath) as! RadioTableViewCell
            cell.nameLbl.text = tmp.name
            cell.setSelected(selected: tmp.selected)
            
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < sortArray.count{
            sortArray.deselected()
            sortArray[indexPath.row].selected = true
            sortTableView.reloadData()
        }
    }

}

