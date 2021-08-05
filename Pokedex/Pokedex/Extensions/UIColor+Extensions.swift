//
//  UIColor+Extensions.swift
//  Pokedex
//
//  Created by Martin García on 7/12/21.
//

import UIKit

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var chars = Array(hex.hasPrefix("#") ? hex.dropFirst() : hex[...])
                switch chars.count {
                case 3:
                    chars = chars.flatMap { [$0, $0] }
                case 6:
                    break
                default:
                    return nil
                }
                self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                        green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                         blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                         alpha: alpha)
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
