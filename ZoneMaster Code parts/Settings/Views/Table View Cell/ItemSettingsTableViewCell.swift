//
//  ItemSettingsTableViewCell.swift
//  PhysioZone
//
//  Created by Nikola Popovic on 12/23/19.
//  Copyright © 2019 com.newtec-solutions.physiosone. All rights reserved.
//

import UIKit
import SDWebImage
import SafariServices

class ItemSettingsTableViewCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var heightImage: NSLayoutConstraint!
    @IBOutlet var bottomTitle: NSLayoutConstraint!
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var descTextView: UITextView!

    private var videoUrl = ""
    private var vc = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descTextView.delegate = self
        descTextView.isEditable = false
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if isStringEmail(str: URL.absoluteString){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendEmail"), object: URL.absoluteString)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openWebPage"), object: URL.absoluteString)
        }
        return true
    }
    
    public func setInit(title: String, description: String, imageUrl: String, videoUrl: String, vc: UIViewController) {
        titleLabel.text = title
        descLabel.text = description
        
        descTextView.text = description
        
        if let attributedString = makeEmailAttributedStringIfNeeded(text: description) {
            descTextView.attributedText = attributedString
        }
        
        self.vc = vc
        if videoUrl != "" || imageUrl != "" {
            
            if videoUrl != "" {
                self.videoUrl = videoUrl
                itemImageView.sd_setImage(with: URL(string: getYouTubeImageUrl(videoId: videoUrl))) { (image, error, cache, url) in
                    // TODO: calculate height
                    if error == nil {
                        print("Height image after download: \(image!.size.height)")
                        self.presentImageView(height: image!.size.height, width: image!.size.width)
                    } else {
                        self.hideImageView()
                    }
                }
            } else {
                itemImageView.sd_setImage(with: URL(string: imageUrl)) { (image, error, cache, url) in
                    // TODO: calculate height
                    if error == nil {
                        print("Height image after download: \(image!.size.height)")
                        self.presentImageView(height: image!.size.height, width: image!.size.width)
                        self.playButton.isHidden = true
                    } else {
                        self.hideImageView()
                    }
                }
            }
        } else {
            hideImageView()
        }
    }
    
    func makeEmailAttributedStringIfNeeded(text: String) -> NSAttributedString? {
        let result = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5), NSAttributedString.Key.font : UIFont(name: "SFUIText-Light", size: 13)!])
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let nsText = text as NSString
        do {
            let regExp = try NSRegularExpression(pattern: emailRegex, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, text.count)
            let matches = regExp.matches(in: text, options: .reportProgress, range: range)
            
            if matches.count == 0 {
                return makeURLAttributedStringIfNeeded(text:result)
            }

            for match in matches {
                
                result.addAttribute(.link, value: nsText.substring(with: match.range), range: match.range)
            }

        } catch _ {
        }

        return makeURLAttributedStringIfNeeded(text:result)
    }
    
    func makeURLAttributedStringIfNeeded(text: NSMutableAttributedString?) -> NSAttributedString? {
        
        if text == nil {
            return nil
        }
        
        let result = text
        let NSStr: NSString = NSString(string: text!.string)
        
        let types: NSTextCheckingResult.CheckingType = .link

        let detector = try? NSDataDetector(types: types.rawValue)

        guard let detect = detector else {
            return text
        }
        
        let content = text!.string

        let matches = detect.matches(in: content, options: .reportCompletion, range: NSMakeRange(0, content.count))

        for match in matches {
            result!.addAttribute(.link, value: NSStr.substring(with: match.range), range: match.range)
        }

        return result
    }
    
    func isStringEmail(str: String)-> Bool{
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
            
        do{
            let regExp = try NSRegularExpression(pattern: emailRegex, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, str.count)
            let matches = regExp.matches(in: str, options: .reportProgress, range: range)
            return matches.count != 0

        }catch _ {
            return false
        }
    }
    
    private func presentImageView(height: CGFloat, width: CGFloat) {
        let widthImageCell = itemImageView.frame.size.width
        let heightImageCell = (widthImageCell / width) * height
        heightImage.constant = heightImageCell
        bottomTitle.constant = 16
        playButton.isHidden = false
    }
    
    private func hideImageView() {
        heightImage.constant = 0
        bottomTitle.constant = 0
        playButton.isHidden = true
    }
    
    @IBAction func playAction(_ sender: UIButton) {
        NavigationUtils.presentYouTubeVC(vc: vc, videoUrl: videoUrl)
    }
}
