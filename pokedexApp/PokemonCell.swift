//
//  PokemonCell.swift
//  pokedexApp
//
//  Created by Pritinder Singh  on 7/7/16.
//  Copyright © 2016 Pritinder Singh . All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 6.0 
    }
    
    func configureCell(pokemon: Pokemon){
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString 
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    
    }
}
