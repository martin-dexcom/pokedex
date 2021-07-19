//
//  InfoView.swift
//  Pokedex
//
//  Created by Daniel Moreno on 7/19/21.
//

import Foundation
import UIKit

class InfoView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var infoTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed("InfoView", owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
