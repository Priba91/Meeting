//
//  UIButtonExtension.swift
//  JobDeal
//
//  Created by Priba on 12/7/18.
//  Copyright © 2018 Priba. All rights reserved.
//

import Foundation
import UIKit
import TransitionButton

extension UIButton{
    
    func setupTitleForKey(key:String, uppercased:Bool = false){
        self.setTitle(LanguageManager.sharedInstance.getStringForKey(key: key, uppercased: uppercased), for: .normal)
    }
    
    func setupForLayoutTypeBlack(){
        self.layer.cornerRadius = 8
        
        self.backgroundColor = UIColor.black
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
    }
    
    func setupForLayoutTypeUnfiled(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.setHalfCornerRadius()
        
        self.backgroundColor = UIColor.clear
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
    }
    
    func setupMinFontScale(){
        self.titleLabel?.numberOfLines = 1;
        self.titleLabel?.adjustsFontSizeToFitWidth = true;
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
    }
    
    func setTypeSelectionStyle(){
        self.centerTextAndImage(padding: 6)
        self.setTitleColor(.mangoGreen, for: .selected)
        self.tintColor = .lightGray
        
        self.setTitleColor(.lightGray, for: .normal)
        self.titleLabel?.textAlignment = .center
    }

    func centerTextAndImage(padding: CGFloat) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
}
