//
//  UIColor+Extensions.swift
//  Pokedex
//
//  Created by Martin García on 7/12/21.
//

import UIKit

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var cHex: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cHex.hasPrefix("#") {
            cHex.remove(at: cHex.startIndex)
        }
        
        guard cHex.count == 6 else {
            self.init(red: 0, green: 0,blue: 0, alpha: 1.0)
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cHex).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255,
                       alpha: CGFloat(1.0))
    }
    
    struct TypeColors {
        
        private static let colorDictionary: [String: UIColor?] = [
            "normal" : UIColor(hex: "#A8A77A"),
            "fire" : UIColor(hex: "#EE8130"),
            "water" : UIColor(hex: "#6390F0"),
            "electric" : UIColor(hex: "#F7D02C"),
            "grass" : UIColor(hex: "#7AC74C"),
            "ice" : UIColor(hex: "#96D9D6"),
            "fighting" : UIColor(hex: "#C22E28"),
            "poison" : UIColor(hex: "#A33EA1"),
            "ground" : UIColor(hex: "#A33EA1"),
            "flying" : UIColor(hex: "#A98FF3"),
            "psychic" : UIColor(hex: "#F95587"),
            "bug" : UIColor(hex: "#A6B91A"),
            "rock" : UIColor(hex: "#B6A136"),
            "ghost" : UIColor(hex: "#735797"),
            "dragon" : UIColor(hex: "#6F35FC"),
            "dark" :  UIColor(hex: "#705746"),
            "steel" : UIColor(hex: "#B7B7CE"),
            "fairy" : UIColor(hex: "#D685AD")
        ]
        
        static func getColor(fromType type: String) -> UIColor {
            guard let color = colorDictionary[type] else {
                return .black
            }
            
            return color ?? .black
        }
    }
}
