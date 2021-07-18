//
//  StatElement.swift
//  Pokedex
//
//  Created by Martin García on 7/18/21.
//

import UIKit

/// Stats Element to be used in the Pokemon View
class StatElement: UIView {
    
    convenience
    init(name: String, power: Int) {
        self.init()
        commonInitializer(stats: (name, power))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitializer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInitializer(stats: (name: String, power: Int)? = nil) {
        guard let stats = stats else { return }
        
        // Add Horizontal Stack
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        // Add Stat Name label
        let lblStat = UILabel()
        lblStat.text = " " + stats.name.uppercased()
        lblStat.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        lblStat.textColor = .white
        horizontalStackView.addArrangedSubview(lblStat)
        
        // Add a Spacer
        let spacer = UIView()
        horizontalStackView.addArrangedSubview(spacer)
        
        // Add a Power
        let lblPower = UILabel()
        lblPower.text = String(stats.power) + " "
        lblPower.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        lblPower.textColor = .white
        horizontalStackView.addArrangedSubview(lblPower)
        
        
        self.addSubview(horizontalStackView)
        self.backgroundColor = .gray
        self.round()
    }
}
