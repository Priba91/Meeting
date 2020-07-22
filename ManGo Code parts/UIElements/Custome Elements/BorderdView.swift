//
//  BorderdView.swift
//  ManGO
//
//  Created by Priba on 6/25/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class BorderdView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        showBorder()
    }

    func hideBorder(){
        self.layer.borderColor = UIColor.clear.cgColor
    }

    func showGrayBorder(){
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func showBorder(){
        self.layer.borderColor = UIColor.mangoGreen.cgColor
    }
}

extension Array where Element: BorderdView {
    func hideBorders() {
        for view in self {
            view.hideBorder()
        }
    }
    
    func showBorders() {
        for view in self {
            view.showBorder()
        }
    }
}
