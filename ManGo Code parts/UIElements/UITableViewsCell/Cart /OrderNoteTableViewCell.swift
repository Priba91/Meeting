//
//  OrderNoteTableViewCell.swift
//  ManGO
//
//  Created by Priba on 8/12/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents

class OrderNoteTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var noteTextView: MDCTextField!
    var arrayOftextFieldControllerFloating = [MDCTextInputController]()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        checkImageView.tintColor = .lightGray
        
        noteTextView.returnKeyType = .done
        
        arrayOftextFieldControllerFloating.append(noteTextView.setupInitState(placeholderKey: "special_note", returnKeyType: .done))
        noteTextView.delegate = self
    }
    
    func populateWith(item: MenuItem){
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeKeyboard"), object: nil)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkImageView.tintColor = .mangoGreen
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            checkImageView.tintColor = .lightGray
        }else{
            checkImageView.tintColor = .mangoGreen
        }
    }

    
    //TODO: Clean this if needed
    
//    func checkTextViewState() {
//
//        if noteTextView.text == "" || noteTextView.text == LanguageManager.sharedInstance.getStringForKey(key: "special_note") {
//            noteTextView.text = LanguageManager.sharedInstance.getStringForKey(key: "special_note")
//            noteTextView.textColor = .lightGray
//            checkImageView.tintColor = .lightGray
//
//        }else{
//            noteTextView.textColor = .darkText
//            checkImageView.tintColor = .mangoGreen
//        }
//
//    }
//
//    //MARK: - TextView Delegate
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//
//        return true
//    }
//
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        if noteTextView.text == LanguageManager.sharedInstance.getStringForKey(key: "type_a_message") {
//            noteTextView.text = ""
//            noteTextView.textColor = .darkText
//            checkImageView.tintColor = .mangoGreen
//        }
//        return true
//    }
//
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        checkTextViewState()
//        return true
//    }
}
