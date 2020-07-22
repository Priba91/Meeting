import UIKit
import MaterialComponents

protocol DeliveryPhoneCellDelegate {
    func didUpdatePhoneNumber(number: String)
}

class DeliveryPhoneTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var phoneTextView: MDCTextField!
    var arrayOftextFieldControllerFloating = [MDCTextInputController]()
    @IBOutlet weak var leftLbl: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    
    var delegate: DeliveryPhoneCellDelegate?
    
    var helperPhone = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        iconImageView.tintColor = .lightGray
        arrayOftextFieldControllerFloating.append(phoneTextView.setupInitState(placeholderKey: "contact_number", returnKeyType: .done))
        phoneTextView.keyboardType = .phonePad
        phoneTextView.delegate = self
        phoneTextView.clearButtonMode = .never

    }
    
    func populateWith(order: OrderModel){
        leftLbl.setupTitleForKey(key: "change")

        if order.address.phone != "" {
            phoneTextView.text = order.address.phone
        }else{
            phoneTextView.text = DataManager.sharedInstance.logedUser.phone
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        iconImageView.tintColor = .mangoGreen
        helperPhone = textField.text ?? ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        iconImageView.tintColor = .lightGray
        if textField.text != helperPhone {
            delegate?.didUpdatePhoneNumber(number: textField.text ?? "")
        }
    }
    
    @IBAction func leftBtnAction(_ sender: Any) {
        if phoneTextView.isFirstResponder {
            
            phoneTextView.resignFirstResponder()
            leftLbl.setupTitleForKey(key: "change")
        }else{
            phoneTextView.becomeFirstResponder()
            leftLbl.setupTitleForKey(key: "save")

        }
    
    }
}
