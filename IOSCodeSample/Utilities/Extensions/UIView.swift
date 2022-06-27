//
//  UIView.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    ///To set constraint for picker views
    func setPickerConstraint(toView: UIView = UIView()) {
        self.translatesAutoresizingMaskIntoConstraints = false
        toView.addSubview(self)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: toView.topAnchor),
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: 47),
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -47)
        ])
    }

    ///To set nibs
    func nibSetup(nibName: NibNames) {
        backgroundColor = .clear
        let view = Bundle(for: self.classForCoder).loadNibNamed(nibName.rawValue, owner: self, options: nil)?.first as? UIView
        view?.frame = bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view?.translatesAutoresizingMaskIntoConstraints = true
        view?.isUserInteractionEnabled = true
        if let view = view {
            addSubview(view)
        }
    }

    ///To add line to view:-
    enum LinePosition {
        case top
        case bottom
    }

    ///To add line to view (Method)
    func addLineToView(position: LinePosition, color: UIColor, width: Double = 1.0) {
        guard (self.viewWithTag(55555) == nil) else{// to avoide duplicate view adding process
            return
        }
        let lineView = UIView()
        lineView.tag = 55555
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)
        let metrics = ["width": NSNumber(value: width)]
        let views = ["lineView": lineView]
        let options = NSLayoutConstraint.FormatOptions(rawValue: 0)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|",
                                                           options: options,
                                                           metrics: metrics,
                                                           views: views))
        switch position {
        case .top:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]",
                                                               options: options,
                                                               metrics: metrics,
                                                               views: views))
        case .bottom:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|",
                                                               options: options,
                                                               metrics: metrics,
                                                               views: views))
        }
    }
    
    /// to add rounded corner with default value
    func addCornerRadius(value: CGFloat = 6.0) {
        layer.cornerRadius = value
    }

    /// to add rounded corner with side and radius
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let cgSize = CGSize(width: radius, height: radius)
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cgSize)
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }

    /// to add shadow
    func addShadow(shadowOffSet: CGSize = CGSize(width: 5, height: 5), radius: CGFloat = 10,color: UIColor = AppColors.shadowLightGrey,opacity: Float = 0.2) {
        layer.masksToBounds = false
        layer.shadowOffset = shadowOffSet
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
    }

    /// to add border
    func addBorder(width: CGFloat = 1, color: UIColor = #colorLiteral(red: 0.9098039216, green: 0.9215686275, blue: 0.9254901961, alpha: 1)) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

}

extension UIView {
    @IBInspectable
    var cornersRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var circleView: Bool {
        get {
            return true
        }
        set {
            layer.cornerRadius = self.frame.height / 2
            clipsToBounds = true
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    //=======================================================================
    // MARK:- Load View From Nib
    //=======================================================================

    func loadViewFromNib() {
        
        let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
        let view = Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let views = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        setNeedsUpdateConstraints()
    }
}

extension UIView{
    func animateFromBottom(){
        self.self.frame.origin.y  += self.bounds.height
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.frame.origin.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}

extension UIView {
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }

}
final class CustomVisualEffectView: UIVisualEffectView {
    /// Create visual effect view with given effect and its intensity
    ///
    /// - Parameters:
    ///   - effect: visual effect, eg UIBlurEffect(style: .dark)
    ///   - intensity: custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale
    init(effect: UIVisualEffect, intensity: CGFloat) {
        theEffect = effect
        customIntensity = intensity
        super.init(effect: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
    
    deinit {
        animator?.stopAnimation(true)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        effect = nil
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
            self.effect = theEffect
        }
        animator?.fractionComplete = customIntensity
    }
    
    private let theEffect: UIVisualEffect
    private let customIntensity: CGFloat
    private var animator: UIViewPropertyAnimator?
}

