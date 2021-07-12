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
                         alpha: 1.0)
    }
    
    private struct PokemonType {
        static let normal = UIColor(hex: "#A8A77A")
        static let fire = UIColor(hex: "#EE8130")
        static let water = UIColor(hex: "#6390F0")
        static let electric = UIColor(hex: "#F7D02C")
        static let grass = UIColor(hex: "#7AC74C")
        static let ice = UIColor(hex: "#96D9D6")
        static let fighting = UIColor(hex: "#C22E28")
        static let poison = UIColor(hex: "#A33EA1")
        static let ground = UIColor(hex: "#E2BF65")
        static let flying = UIColor(hex: "#A98FF3")
        static let psychic = UIColor(hex: "#F95587")
        static let bug = UIColor(hex: "#A6B91A")
        static let rock = UIColor(hex: "#B6A136")
        static let ghost = UIColor(hex: "#735797")
        static let dragon = UIColor(hex: "#6F35FC")
        static let dark = UIColor(hex: "#705746")
        static let steel = UIColor(hex: "#B7B7CE")
        static let fairy = UIColor(hex: "#D685AD")
    }
}
