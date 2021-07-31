//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Martin García on 7/24/21.
//

import UIKit
import SDWebImage
// MARK: - Pokemon Controller
class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrder: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var imgPokemon: UIImageView!
    
    @IBOutlet weak var vStats: UIView!
    @IBOutlet weak var statsVstack: UIStackView!
    
    var pokemon: Pokemon?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {

      // TODO this code will change

        // Setting up our labels
        lblName.text = pokemon?.name?.uppercased()
        lblOrder.text = "#\(pokemon?.order ?? 0)"
        lblType.text = "Fire type" //pokemon?.type?.lowercased()
        
        // Setting up our image
//        let url = URL(string: pokemon?.image ?? "")
        let url = URL(string:  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png" )


        if let unwrappedURL = url {
            imgPokemon.sd_setImage(with: unwrappedURL, completed: nil)
        }
        
      // Setup my Vstac?k
        /*pokemon?.stats.forEach { (name: String, power: Int) in
            let statElement = StatElement(name, power)
            statsVstack.addArrangedSubview(statElement)
        }*/
        pokemon?.stats?.forEach({ stat in
            let statElement = StatElement(stat.stat?.name ?? "", stat.baseStat ?? 0)
            statsVstack.addArrangedSubview(statElement)
        })
        
        
        
        // Add a corner radius
        vStats.roundCorners(withRadius: 30)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class StatElement: UIView {
    
    convenience init(_ name: String,_ power: Int) {
        self.init()
        commonInitializer(name: name, power: power)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInitializer(name: String, power: Int) {
        // Add a Horizontal Stack
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        
        // Create an UILabel for the name
        let lblName = UILabel()
        lblName.text = name.uppercased()
        lblName.font = UIFont.systemFont(ofSize: 35,
                                         weight: .heavy)
        
        horizontalStack.addArrangedSubview(lblName)
        
        // Create an UILabel for the power
        let lblPower = UILabel()
        lblPower.text = String(power)
        lblPower.font = UIFont.systemFont(ofSize: 35,
                                          weight: .heavy)
        lblPower.textAlignment = .right
        horizontalStack.addArrangedSubview(lblPower)
        
        // Adding it to the subview
        self.addSubview(horizontalStack)
        self.backgroundColor = .gray
        self.roundCorners(withRadius: 15)
    }
}
