//
//  AvatarRegisterViewController.swift
//  ManGO
//
//  Created by Priba on 7/8/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import LGButton

class AvatarRegisterViewController: BaseViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var phone = ""
    var email = ""
    var username = ""
    var verificationId = 0
    var avatarUrl = ""
    var imagePicker = UIImagePickerController()

    var isUploadingImage = false
    var doesNextBtnRequested = false

    @IBOutlet weak var topLbl: UILabel!
    
    @IBOutlet weak var editIcon: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nextBtn: LGButton!
    @IBOutlet weak var bottomLbl: UILabel!
    
    let style : MDCTextInputControllerUnderline? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Super Methods
    
    override func setupUI() {
        avatarImageView.setHalfCornerRadius()
        avatarImageView.layer.borderColor = UIColor.mangoGreen.cgColor
        avatarImageView.layer.borderWidth = 1.5
        avatarImageView.tintColor = .mangoGreen
        
        editIcon.setHalfCornerRadius()
        editIcon.isHidden = true
        
        nextBtn.setHalfCornerRadius()
    }
    
    override func setupStrings() {
        
        nextBtn.setupForTitleKey(key: "next")
        
        topLbl.setupTitleForKey(key: "registration_3_3")
        bottomLbl.setupTitleForKey(key: "add_avatar_footer")
        
    }
    
    override func loadData() {
        
    }
    
    func validate() -> Bool{
        
        
        return true
}
    
    //MARK: - Buttons Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        self.nextBtn.isLoading = true

        if isUploadingImage {
            doesNextBtnRequested = true
            return
        }
//
//        ServerManager.sharedInstance.register(phone: phone, email: email, verificationId: verificationId, username: username, avatarUrl: avatarUrl) { (response, success, errMsg) in
//            self.nextBtn.isLoading = false
//            if success! {
//
//                if let jwt = response["jwt"] as? String, let userDict = response["user"] as? NSDictionary {
//
//                    let formater = DateFormatter()
//                    formater.dateFormat = "dd.MM.yyyy HH:mm"
//                    UserDefaults.standard.set(formater.string(from: Date()), forKey: "lastLoginDate")
//
//                    DataManager.sharedInstance.loadAddresses()
//
//                    UserDefaults.standard.set(jwt, forKey: "authToken")
//                    UserDefaults.standard.set(self.phone, forKey: "phone")
//
//                    DataManager.sharedInstance.logedUser = UserModel.init(dict: userDict)
//                    NotificationCenter.default.post(name: Notification.Name(rawValue: "dismissSplashLoader"), object: nil)
//
//                    UserDefaults.standard.set(DataManager.sharedInstance.logedUser.uid, forKey: "uid")
//
//                    DataManager.sharedInstance.loadTypes(dict: response)
//
//                    let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
//                    self.navigationController?.pushViewController(vc, animated: true)
//
//
//                }else{
//
//                    //TODO: Proveri ove errMsg poruke u ovim situacijama
//                    AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
//
//                    })
//                }
//            }else{
//                AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
//
//                })
//            }
//        }
    }
    
    @IBAction func helpBtnAction(_ sender: Any) {
        //TODO: WHY PHONE NUMBER
    }
    
    @IBAction func chooseImageBtnAction(_ sender: Any) {
        
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: LanguageManager.sharedInstance.getStringForKey(key: "select_image_source"), message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: LanguageManager.sharedInstance.getStringForKey(key: "cancel"), style: .cancel) { _ in

        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let galleryActionButton = UIAlertAction(title: LanguageManager.sharedInstance.getStringForKey(key: "gallery"), style: .default)
        { _ in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Button capture")
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .savedPhotosAlbum;
                
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        actionSheetControllerIOS8.addAction(galleryActionButton)
        
        let takeNewActionButton = UIAlertAction(title: LanguageManager.sharedInstance.getStringForKey(key: "takeNew"), style: .default)
        { _ in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Button capture")
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .camera;
                
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        actionSheetControllerIOS8.addAction(takeNewActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
        
    }
    
    //MARK: - Image Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = chosenImage
        editIcon.isHidden = false
        isUploadingImage = true
        let imgData = chosenImage.jpegData(compressionQuality: 0.7)
        
        ServerManager.sharedInstance.uploadAvatarImage(imageData: imgData!) { (response, success) in
            self.isUploadingImage = false
            
            if(success!){
                self.avatarUrl = response 
                if self.doesNextBtnRequested {
                    self.nextBtnAction(self.nextBtn)
                }
            }else{
                self.nextBtn.isLoading = false
                AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: "", completion: { (index, str) in
                    
                })
            }
        }
        
        dismiss(animated:true, completion: nil)
    }
    
    
    
}
