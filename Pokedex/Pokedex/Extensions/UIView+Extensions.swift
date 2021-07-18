//
//  UIView+Extensions.swift
//  Pokedex
//
//  Created by Martin García on 7/18/21.
//

import UIKit


extension UIView {
    /// Array of all corners in a UIView
    private static let allCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    
    /// Round a UIView
    func round(radius: CGFloat = 10, corners: CACornerMask = allCorners) {
        layer.cornerRadius = radius
    }
    
    /// Add a shadow on top of the element
    func withShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shouldRasterize = true
    }
}
