//
//  UIViewExtension.swift
//  JobDeal
//
//  Created by Priba on 12/8/18.
//  Copyright © 2018 Priba. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func dropShadow2() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
    }
    
    func dropShadow3() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height:  4)
        self.layer.shadowRadius = 3
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = false
        self.layer.rasterizationScale = UIScreen.main.scale
        self.clipsToBounds = false
    }
    
    func dropShadow4() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.65
        self.layer.shadowOffset = CGSize(width: 0, height:  4)
        self.layer.shadowRadius = 6
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = false
        self.layer.rasterizationScale = UIScreen.main.scale
        self.clipsToBounds = false
    }

    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func setHalfCornerRadius(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func makeTongueMask(){
        let maskImageView = UIImageView()
        maskImageView.contentMode = .scaleAspectFill
        maskImageView.image = UIImage(named: "avatar_mask_150")
        maskImageView.frame = self.bounds
        self.mask = maskImageView
    }
    
    func addWhiteGradientToBackground(){
        
        let colorLeft = UIColor.red.cgColor
        let colorRight = UIColor.blue.cgColor
        let gl: CAGradientLayer = CAGradientLayer()
        gl.colors = [ colorLeft, colorRight]
        gl.locations = [0.0, 1.0]
        gl.startPoint = CGPoint(x: 0.0, y: 1.0)
        gl.endPoint = CGPoint(x: 1.0, y: 1.0)
        gl.frame = self.frame
        gl.needsDisplayOnBoundsChange = true
        self.layer.insertSublayer(gl, at: 0)
    }
    
    func addGreenGradientToBackground(){
        
        let colorTop = UIColor.mangoGreen.cgColor
        let colorBot = UIColor(white: 1, alpha: 0).cgColor
        let gl: CAGradientLayer = CAGradientLayer()
        gl.colors = [ colorTop, colorBot]
        gl.locations = [0.0, 1.0]
        gl.startPoint = CGPoint(x: 1.0, y: 0.0)
        gl.endPoint = CGPoint(x: 1.0, y: 1.0)
        gl.frame = self.frame
        gl.needsDisplayOnBoundsChange = true
        self.layer.insertSublayer(gl, at: 0)
    }
    
    func addTransition(){
        let transition = CATransition()
        transition.duration = 0.1
        transition.type = CATransitionType.fade
        self.window!.layer.add(transition, forKey: kCATransition)
    }
    
    func addTopTransition(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        self.window!.layer.add(transition, forKey: kCATransition)
    }
    
    func addBottomTransition(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.window!.layer.add(transition, forKey: kCATransition)
    }
    
    func addGrayBorderStroke(){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
