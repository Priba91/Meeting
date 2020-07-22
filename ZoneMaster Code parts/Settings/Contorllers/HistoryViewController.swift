//
//  HistoryViewController.swift
//  PhysioZone
//
//  Created by Nikola Popovic on 12/25/19.
//  Copyright © 2019 com.newtec-solutions.physiosone. All rights reserved.
//

import UIKit

protocol HistoryViewControllerDelegate {
    func selectedDailyHistory(date: String)
    func selectedTrainingHistory(training: TrainingModeModel)
}

class HistoryViewController: UIViewController {
    
    public var delegate: HistoryViewControllerDelegate?
    
    @IBOutlet var bateryLoaderBackgroundView: UIView!
    @IBOutlet var bateryLoaderView: UIView!
    @IBOutlet var bateryLifiLabel: UILabel!
    @IBOutlet weak var batteryBarLeftConstraint: NSLayoutConstraint!

    @IBOutlet var navTitleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBarView: UIView!
    
    private let headerIdentifier = "HistoryHeaderView"
    private let cellIdentifier = "HistoryTableViewCell"
    
    private let numberOfTrenings = 20
    private let numberOfDaily = 10
    
    var dailly = [String]()
    var trainings = [TrainingModeModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        batteryBarLeftConstraint.constant = self.view.frame.width
        setTableView()
        prepareData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBateryLifeViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setNavBar()
    }
    
    // MARK: - Private functions
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: headerIdentifier, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setBateryLifeViews() {
        
        bateryLoaderBackgroundView.backgroundColor = topPurpleBacground
        bateryLoaderView.backgroundColor = topPurpleBacground
        bateryLifiLabel.text = "s_energymeter_batery_life".localized
        
        if let battetyLevelWidth = UserDefaults.standard.value(forKey: "battetyLevelWidth") as? Double{
            self.batteryBarLeftConstraint.constant = CGFloat(battetyLevelWidth)
        }
        
        if let battetyLevel = UserDefaults.standard.value(forKey: "battetyLevelPercent") as? Double{
            bateryLifiLabel.text = "s_energymeter_batery_life".localized + " \(Int(Double(battetyLevel) * 100))%"
        }
        
        bateryLoaderBackgroundView.isHidden = !TrainingManager.shared.isTrainingON
        bateryLifiLabel.isHidden = !TrainingManager.shared.isTrainingON
        
    }
    
    private func setNavBar() {
        navBarView.setGradientBackground()
        navTitleLabel.text = "s_settings_history".localized
    }
    
    private func prepareData(){
        
        dailly = CDManager.shared.getDailyHistoryForWeek()
        trainings = CDManager.shared.getTrainings()
        trainings.reverse()
        
        tableView.reloadData()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Table View Data Soruce
extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numberOfSections = 0
        
        if dailly.count > 0{
            numberOfSections += 1
        }
        
        if trainings.count > 0{
            numberOfSections += 1
        }
        
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 { // Daily
            return dailly.count == 0 ? trainings.count : dailly.count
        } else { // Trainings
            return trainings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HistoryTableViewCell
        let section = indexPath.section
        if section == 0 {
            if dailly.count == 0 {
                if indexPath.row < trainings.count {
                    cell.setInit(title: trainings[indexPath.row].toHistoryString())
                    return cell
                }
            }else{
                if indexPath.row < dailly.count {
                    cell.setInit(title: "daily".localized + " | " + dailly[indexPath.row])
                    return cell
                }
            }
        } else {
            if indexPath.row < trainings.count {
                cell.setInit(title: trainings[indexPath.row].toHistoryString())
                return cell
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! HistoryHeaderView
        if section == 0 {
            
            if dailly.count == 0 {
                headerView.setInit(text: "s_history_header_title_training".localized)
                return headerView
            }else{
                headerView.setInit(text: "s_history_header_title_daily".localized)
                return headerView
            }
        } else {
            headerView.setInit(text: "s_history_header_title_training".localized)
            return headerView
        }
    }
}

// MARK: Table View Delegate
extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        if section == 0 {
            if dailly.count == 0 {
                if indexPath.row < trainings.count {
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "selectedTrainingFromHistory"), object: trainings[indexPath.row])
                }
            }else{
                if indexPath.row < dailly.count {
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "selectedDailyFromHistory"), object: dailly[indexPath.row])
                }
            }
        } else {
            if indexPath.row < trainings.count {
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "selectedTrainingFromHistory"), object: trainings[indexPath.row])
            }
        }
    }
}
