//
//  ViewController.swift
//  pokedexApp
//
//  Created by Pritinder Singh  on 7/7/16.
//  Copyright © 2016 Pritinder Singh . All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    var fliteredPokemons = [Pokemon]()
    var pokemons = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        configMusic()
        parsePokemonCSV()
        
    }
    
    var inSearchMode : Bool = false
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
        
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
            
        }else{
            
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            
            fliteredPokemons = pokemons.filter({$0.name.rangeOfString(lower) != nil})
            collectionView.reloadData()
        }
    }
    
    
    
    // Audio Set Up
    
    var musicPlayer: AVAudioPlayer!
    
    func configMusic() {
    
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
        
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        
        }catch let err as NSError {
        
            print(err.debugDescription)
        }
    
    
    }
    
    @IBAction func musicBtnTapped(sender: UIButton!){
    
        if musicPlayer.playing {
        
            musicPlayer.stop()
            sender.alpha = 0.5
            
        }else {
            
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
   
    
    // Got Data from the CSV file and Parsed it
    
    func parsePokemonCSV() {
    
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do{
        
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
            
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let newPokemon = Pokemon(name: name, pokedexId: pokeId)
                
                pokemons.append(newPokemon)
            
            }
        }catch let err as NSError {
        
            print(err.debugDescription)
        }
    
    }
    
    
   
    
    // Collection View Functions
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as? PokemonCell {
            
            let pokemon: Pokemon!
            
            if inSearchMode {
                
                pokemon = fliteredPokemons[indexPath.row]
            }else {
                
                pokemon = pokemons[indexPath.row]
            }
            
            cell.configureCell(pokemon)
            
            return cell
        }else {
        
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
        
                return fliteredPokemons.count
        }
        
        return pokemons.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(93, 93)
    }
    
    

  

}

