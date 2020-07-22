//
//  AvatarRegisterViewController.swift
//  ManGO
//
//  Created by Priba on 4/9/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import LGButton

class RegistrationGroupedViewController: BaseViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var phone = ""
    var email = ""
    var firstname = ""
    var lastname = ""
    var verificationId = 0
    var avatarUrl = ""
    var imagePicker = UIImagePickerController()
    
    var isUploadingImage = false
    var doesNextBtnRequested = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var nextBtn: LGButton!
    @IBOutlet weak var bottomLbl: UILabel!
    @IBOutlet weak var firstnameTF: MDCTextField!
    @IBOutlet weak var lastnameTF: MDCTextField!
    @IBOutlet weak var emailTF: MDCTextField!
    
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
        
        avatarImageView.setHalfCornerRadius()
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = UIColor.mangoGreen.cgColor

        nextBtn.setHalfCornerRadius()
        
        arrayOftextFieldControllerUnderline.append(firstnameTF.setupInitUnderlineState(returnKeyType: .next))
        arrayOftextFieldControllerUnderline.append(lastnameTF.setupInitUnderlineState(returnKeyType: .next))
        arrayOftextFieldControllerUnderline.append(emailTF.setupInitUnderlineState(returnKeyType: .done))

    }
    
    override func setupStrings() {
        
        nextBtn.setupForTitleKey(key: "next", uppercase: true)
        nextBtn.titleColor = .white
        nextBtn.bgColor = .mangoGreen
        nextBtn.loadingSpinnerColor = .white
        
        bottomLbl.setupTitleForKey(key: "registration_bottom_desc")
        
        firstnameTF.placeholder = LanguageManager.sharedInstance.getStringForKey(key: "firstname")
        lastnameTF.placeholder = LanguageManager.sharedInstance.getStringForKey(key: "lastname")
        emailTF.placeholder = LanguageManager.sharedInstance.getStringForKey(key: "email")
        nextBtn.setHalfCornerRadius()
        
    }
    
    override func loadData() {
        
    }
    
    func validate() -> Bool{

        firstnameTF.cleanSpacesAndNewLines()
        if firstnameTF.text == "" {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "must_enter_firstname"))
            return false
        }
        
        lastnameTF.cleanSpacesAndNewLines()
        if lastnameTF.text == "" {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "must_enter_lastname"))
            return false
        }
        
        emailTF.cleanSpacesAndNewLines()
        if !Utils.isValidEmail(enteredEmail: emailTF.text ?? "") {
            self.view.makeToast(LanguageManager.sharedInstance.getStringForKey(key: "wrong_email_format"))
            return false
        }
        
        return true
    }
    
    //MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstnameTF {
            lastnameTF.becomeFirstResponder()
        }else if textField == lastnameTF {
            emailTF.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        
        return true
    }
    
    //MARK: - Keyboard Notifications
    
    override func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: - Buttons Actions

    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        self.view.endEditing(true)

        if !validate(){
            return
        }
        
        self.nextBtn.isLoading = true
        
        if isUploadingImage {
            doesNextBtnRequested = true
            return
        }
        
        ServerManager.sharedInstance.register(phone: phone, email: emailTF.text ?? "", verificationId: verificationId, firstname: firstnameTF.text ?? "", lastname: lastnameTF.text ?? "", avatarUrl: avatarUrl) { (response, success, errMsg) in
            self.nextBtn.isLoading = false
            
            if success! {
                
                if let jwt = response["jwt"] as? String, let userDict = response["user"] as? NSDictionary {
                    
                    let formater = DateFormatter()
                    formater.dateFormat = "dd.MM.yyyy HH:mm"
                    UserDefaults.standard.set(formater.string(from: Date()), forKey: "lastLoginDate")
                    
                    DataManager.sharedInstance.loadAddresses()
                    
                    UserDefaults.standard.set(jwt, forKey: "authToken")
                    UserDefaults.standard.set(self.phone, forKey: "phone")
                    
                    DataManager.sharedInstance.logedUser = UserModel.init(dict: userDict)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "dismissSplashLoader"), object: nil)
                    
                    UserDefaults.standard.set(DataManager.sharedInstance.logedUser.uid, forKey: "uid")
                    
                    DataManager.sharedInstance.loadTypes(dict: response)
                    
                    let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }else{
                    
                    //TODO: Proveri ove errMsg poruke u ovim situacijama
                    AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                        
                    })
                }
            }else{
                AJAlertController.initialization().showAlertWithOkButton(aStrTitle: LanguageManager.sharedInstance.getStringForKey(key: "error_popup_title"), aStrMessage: errMsg, completion: { (index, str) in
                    
                })
            }
        }
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
        addImageBtn.setImage(nil, for: .normal)
        isUploadingImage = true
        let imgData = chosenImage.jpegData(compressionQuality: 0.4)
        
        ServerManager.sharedInstance.uploadAvatarImage(imageData: imgData!) { (response, success) in
            self.isUploadingImage = false
            
            if(success!){
                self.avatarUrl = response
                if self.doesNextBtnRequested {
                    self.nextBtnAction(self.nextBtn!)
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
