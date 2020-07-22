//
//  SettingsViewController.swift
//  PhysioZone
//
//  Created by Nikola Popovic on 11/13/19.
//  Copyright © 2019 com.newtec-solutions.physiosone. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func didSelectItem(type: SelectedSidePanelType)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var settingsNavLabel: UILabel!
    @IBOutlet var menuImageView: UIImageView!
    @IBOutlet var designedByLabel: UILabel!
    @IBOutlet var designedImage: UIImageView!
    @IBOutlet var navBarView: UIView!
    
    private let cellIdentifier = "SettingsTableViewCell"
    private let numberOfCells = 6
    
    public var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGradients()
    }
    
    // MARK: - Private Functions
    private func setInit() {
        setLabels()
        setTableView()
        setGestrue()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setLabels() {
        settingsNavLabel.text = "s_settings_settings".localized
        designedByLabel.text = "App Designed by kha-concepts.com"
    }
    
    private func setGradients() {
        view.setGradientBackground()
        navBarView.setGradientBackground()
    }
    
    private func setGestrue() {
        menuImageView.isUserInteractionEnabled = true
        menuImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeSideMenuAction)))
    }
    
    // MARK: - Actions
    
    @IBAction func closeBtnAction(_ sender: Any) {
        delegate?.didSelectItem(type: .none)
    }
    
    @objc func closeSideMenuAction() {
        delegate?.didSelectItem(type: .none)
    }
}

// MARK: - Table View Data Source
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SettingsTableViewCell
        let row = indexPath.row
        switch row {
        case 0:
            cell.setInit(title: "s_settings_history".localized, imageName: "history_icon")
            return cell
        case 1:
            cell.setInit(title: "s_settings_payment".localized, imageName: "payment_icon")
            return cell
        case 2:
            cell.setInit(title: "s_settings_about_zone_master".localized, imageName: "about_zone_master_icon")
            return cell
        case 3:
            cell.setInit(title: "s_settings_data_policy".localized, imageName: "data_policy_icon")
            return cell
        case 4:
            cell.setInit(title: "s_settings_terms_of_use".localized, imageName: "terms_of_user_icon")
            return cell
        case 5:
            cell.setInit(title: "s_settings_help".localized, imageName: "exclenation_mark_icon")
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Table View Delegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        switch row {
        case 0:
            // History
            print(indexPath.row)
            delegate?.didSelectItem(type: .history)
            break
        case 1:
            // Payment
            print(indexPath.row)
            delegate?.didSelectItem(type: .payment)
            break
        case 2:
            // About zone master
            print(indexPath.row)
            delegate?.didSelectItem(type: .aboutZoneMaster)
            break
        case 3:
            // Data Policy
            print(indexPath.row)
            delegate?.didSelectItem(type: .dataPolicy)
            break
        case 4:
            // Terms of Use
            print(indexPath.row)
            delegate?.didSelectItem(type: .termsOfUse)
        case 5:
            // Help
            print(indexPath.row)
            delegate?.didSelectItem(type: .help)
            break
        default:
            break
        }
    }
}
