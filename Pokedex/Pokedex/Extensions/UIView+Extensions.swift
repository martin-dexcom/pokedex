//
//  UIView+Extensions.swift
//  Pokedex
//
//  Created by Martin García on 7/24/21.
//

import UIKit

extension UIView {
    /**
     It rounds corners
     - TODO: Make it work with different things
     - Note: Only works on UIViews
     - Parameters:
        - withRadius: The Radius of the Corners
     */
    func roundCorners(withRadius radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
