//
//  PokemonDetailVC.swift
//  pokedexApp
//
//  Created by Pritinder Singh  on 7/7/16.
//  Copyright © 2016 Pritinder Singh . All rights reserved.
//

import UIKit


class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var pokedexId: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        var img = UIImage(named: "\(pokemon.pokedexId)")
        nameLbl.text = pokemon.name
        mainImg.image = img
        currentEvoImg.image = img
        
        
        pokemon.downloadPokemonDetails { () -> () in
            
            self.updateUI()
            
        }
        
    }
    
    func updateUI() {
        
        
        pokemonDescription.text = pokemon.pokeDesc
        type.text = pokemon.type
        defense.text = pokemon.defense
        height.text = pokemon.height
        pokedexId.text = "\(pokemon.pokedexId)"
        weight.text = pokemon.weight
        baseAttack.text = pokemon.attack
       
        
        if pokemon.nextEvoId == "" {
        
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        }else {
        
            
            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvoId)")
            var str = "Next Evolution:  \(pokemon.nextEvoTxt)"
            
            if pokemon.nextEvoLvl != "" {
            
                str += " at LVL\(pokemon.nextEvoLvl)"
                
            }
        }
        
        
    }

    @IBAction func backBtnTapped(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

}
