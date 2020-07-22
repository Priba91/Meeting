//
//  ItemSettingsViewController.swift
//  PhysioZone
//
//  Created by Nikola Popovic on 11/18/19.
//  Copyright © 2019 com.newtec-solutions.physiosone. All rights reserved.
//

import UIKit
import MessageUI

class ItemSettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var navView: UIView!
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    private let cellIdentifier = "ItemSettingsTableViewCell"
    private var info = [Info]()
    
    public var type = SelectedSidePanelType.help
    public var descriptionText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInit()
        //descriptionTextView.attributedText = descriptionText.htmlToAttributedString
        NotificationCenter.default.addObserver(self, selector: #selector(sendEmail(notification:)), name: NSNotification.Name(rawValue: "sendEmail"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openWebPage(notification:)), name: NSNotification.Name(rawValue: "openWebPage"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGradients()
    }
    
    // MARK: - Private Functions
    private func setTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
    }
    
    
    private func setGradients() {
        self.view.setGradientBackground()
        navView.setGradientBackground()
    }
    
    private func setInit() {
        setTable()
        switch type {
        case .history:
            // TODO: - History screen
            textLabel.text = "s_settings_history".localized
            itemImageView.image = UIImage(named: "history_icon")
            info = [Info]()
            tableView.reloadData()
            break
        case .aboutZoneMaster:
            // TODO: Remove this case and present into screen
            textLabel.text = "s_settings_about_zone_master".localized
            itemImageView.image = UIImage(named: "about_zone_master_icon")
            break
        case .dataPolicy:
            textLabel.text = "s_settings_data_policy".localized
            itemImageView.image = UIImage(named: "data_policy_icon")
            getDataPolicy()
            break
        case .termsOfUse:
            textLabel.text = "s_settings_terms_of_use".localized
            itemImageView.image = UIImage(named: "terms_of_user_icon")
            getTermsOfUse()
            break
        case .help:
            textLabel.text = "s_settings_help".localized
            itemImageView.image = UIImage(named: "exclenation_mark_icon")
            getHelp()
            break
        default:
            break
        }
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table View Data Source
extension ItemSettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ItemSettingsTableViewCell
        let infoModel = info[indexPath.row]
        cell.setInit(title: infoModel.title, description: infoModel.content, imageUrl: infoModel.image, videoUrl: infoModel.video, vc: self)
        return cell
    }
}

// MARK: - Table View Delegate
extension ItemSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - API
extension ItemSettingsViewController {
    private func getDataPolicy() {
        ZNNetwoking.shared.getAppDataPolicy { (code, error, response, isConnectedToInternet) in
            if isConnectedToInternet {
                if response != nil {
                    if 200..<299 ~= code {
                        self.info = [Info]()
                        //print("Login success response: \(response as! NSDictionary)")
                        NavigationUtils.closeLoaderVC {
                            if let dataDic = response as? NSDictionary {
                                let dataArray = dataDic["data"] as? NSArray ?? NSArray()
                                for dataItem in dataArray {
                                    let itemDic = dataItem as? [String: Any] ?? [String: Any]()
                                    let infoModel = Info()
                                    infoModel.initWithDic(dic: itemDic)
                                    self.info.append(infoModel)
                                }
                            }
                            self.tableView.reloadData()
                        }
                    } else {
                        NavigationUtils.closeLoaderVC {
                            print("Login error response: \(response as Any)")
                            if let dic = response as? NSDictionary {
                                NavigationUtils.presentWarningErrorPopUps(vc: self, title: dic["message"] as? String ?? "", buttonTitle: "p_error_ok_button".localized)
                            }
                        }
                    }
                } else {
                    NavigationUtils.closeLoaderVC {
                        // TODO: - Print error in toast or some pop up
                        print("Error parse logIn: \(error as Any)")
                        if let err = error {
                            NavigationUtils.presentWarningErrorPopUps(vc: self, title: err, buttonTitle: "p_error_ok_button".localized)
                        } else {
                            NavigationUtils.presentWarningErrorPopUps(vc: self, title: "Something went wrong, please try again later.", buttonTitle: "p_error_ok_button".localized)
                        }
                    }
                }
            } else {
                NavigationUtils.closeLoaderVC {
                    NavigationUtils.presentWarningErrorPopUps(vc: self, title: "p_please_check_your_internet".localized, buttonTitle: "p_error_ok_button".localized)
                }
            }
        }
    }
    
    private func getTermsOfUse() {
        ZNNetwoking.shared.getAppTermsOfUse { (code, error, response, isConnectedToInternet) in
            if isConnectedToInternet {
                if response != nil {
                    if 200..<299 ~= code {
                        self.info = [Info]()
                        //print("Login success response: \(response as! NSDictionary)")
                        NavigationUtils.closeLoaderVC {
                            if let dataDic = response as? NSDictionary {
                                let dataArray = dataDic["data"] as? NSArray ?? NSArray()
                                for dataItem in dataArray {
                                    let itemDic = dataItem as? [String: Any] ?? [String: Any]()
                                    let infoModel = Info()
                                    infoModel.initWithDic(dic: itemDic)
                                    self.info.append(infoModel)
                                }
                            }
                            self.tableView.reloadData()
                        }
                    } else {
                        NavigationUtils.closeLoaderVC {
                            print("Login error response: \(response as Any)")
                            if let dic = response as? NSDictionary {
                                NavigationUtils.presentWarningErrorPopUps(vc: self, title: dic["message"] as? String ?? "", buttonTitle: "p_error_ok_button".localized)
                            }
                        }
                    }
                } else {
                    NavigationUtils.closeLoaderVC {
                        // TODO: - Print error in toast or some pop up
                        print("Error parse logIn: \(error as Any)")
                        if let err = error {
                            NavigationUtils.presentWarningErrorPopUps(vc: self, title: err, buttonTitle: "p_error_ok_button".localized)
                        } else {
                            NavigationUtils.presentWarningErrorPopUps(vc: self, title: "Something went wrong, please try again later.", buttonTitle: "p_error_ok_button".localized)
                        }
                    }
                }
            } else {
                NavigationUtils.closeLoaderVC {
                    NavigationUtils.presentWarningErrorPopUps(vc: self, title: "p_please_check_your_internet".localized, buttonTitle: "p_error_ok_button".localized)
                }
            }
        }
    }
    
    private func getHelp() {
        ZNNetwoking.shared.getAppHelp { (code, error, response, isConnectedToInternet) in
            if isConnectedToInternet {
                if response != nil {
                    if 200..<299 ~= code {
                        self.info = [Info]()
                        //print("Login success response: \(response as! NSDictionary)")
                        NavigationUtils.closeLoaderVC {
                            if let dataDic = response as? NSDictionary {
                                let dataArray = dataDic["data"] as? NSArray ?? NSArray()
                                for dataItem in dataArray {
                                    let itemDic = dataItem as? [String: Any] ?? [String: Any]()
                                    let infoModel = Info()
                                    infoModel.initWithDic(dic: itemDic)
                                    self.info.append(infoModel)
                                }
                            }
                            self.tableView.reloadData()
                        }
                    } else {
                        NavigationUtils.closeLoaderVC {
                            print("Login error response: \(response as Any)")
                            if let dic = response as? NSDictionary {
                                NavigationUtils.presentWarningErrorPopUps(vc: self, title: dic["message"] as? String ?? "", buttonTitle: "p_error_ok_button".localized)
                            }
                        }
                    }
                } else {
                    NavigationUtils.closeLoaderVC {
                        // TODO: - Print error in toast or some pop up
                        print("Error parse logIn: \(error as Any)")
                        if let err = error {
                            NavigationUtils.presentWarningErrorPopUps(vc: self, title: err, buttonTitle: "p_error_ok_button".localized)
                        } else {
                            NavigationUtils.presentWarningErrorPopUps(vc: self, title: "Something went wrong, please try again later.", buttonTitle: "p_error_ok_button".localized)
                        }
                    }
                }
            } else {
                NavigationUtils.closeLoaderVC {
                    NavigationUtils.presentWarningErrorPopUps(vc: self, title: "p_please_check_your_internet".localized, buttonTitle: "p_error_ok_button".localized)
                }
            }
        }
    }
    
    private func getAppForgotPassword() {
        ZNNetwoking.shared.getForgotPassword { (code, error, response, isConnectedToInternet) in
            if isConnectedToInternet {
                if response != nil {
                    if 200..<299 ~= code {
                        self.info = [Info]()
                        //print("Login success response: \(response as! NSDictionary)")
                        NavigationUtils.closeLoaderVC {
                            if let dataDic = response as? NSDictionary {
                                let dataArray = dataDic["data"] as? NSArray ?? NSArray()
                                for dataItem in dataArray {
                                    let itemDic = dataItem as? [String: Any] ?? [String: Any]()
                                    let infoModel = Info()
                                    infoModel.initWithDic(dic: itemDic)
                                    self.info.append(infoModel)
                                }
                            }
                            self.tableView.reloadData()
                        }
                    } else {
                        NavigationUtils.closeLoaderVC {
                            print("Login error response: \(response as Any)")
                            if let dic = response as? NSDictionary {
                                NavigationUtils.presentWarningErrorPopUps(vc: self, title: dic["message"] as? String ?? "", buttonTitle: "p_error_ok_button".localized)
                            }
                        }
                    }
                } else {
                    NavigationUtils.closeLoaderVC {
                        // TODO: - Print error in toast or some pop up
                        print("Error parse logIn: \(error as Any)")
                        if let err = error {
                            NavigationUtils.presentWarningErrorPopUps(vc: self, title: err, buttonTitle: "p_error_ok_button".localized)
                        } else {
                            NavigationUtils.presentWarningErrorPopUps(vc: self, title: "Something went wrong, please try again later.", buttonTitle: "p_error_ok_button".localized)
                        }
                    }
                }
            } else {
                NavigationUtils.closeLoaderVC {
                    NavigationUtils.presentWarningErrorPopUps(vc: self, title: "p_please_check_your_internet".localized, buttonTitle: "p_error_ok_button".localized)
                }
            }
        }
    }
    
    //Mail service
    
    @objc func sendEmail(notification: Notification) {
        
        guard let email = notification.object as? String else{
            return
        }
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    @objc func openWebPage(notification: Notification) {
        
        guard let urlStr = notification.object as? String else{
            return
        }
        
        let url = URL(string: urlStr)
        UIApplication.shared.open(url!)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
