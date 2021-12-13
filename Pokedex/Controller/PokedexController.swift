//
//  PokedexController.swift
//  Pokedex
//
//  Created by Basem El kady on 12/11/21.
//

import UIKit


private let cellIdentifier = "cell"

class PokedexController: UICollectionViewController {
    
  //MARK: - properties
    var pokemonArray: [Pokemon]?
    let searchBar = UISearchBar()
    var filteredArray: [Pokemon]?
  
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        fetchPokemons()
    }
    
    //MARK: - Selectors
    
    @objc func hideSearchIconAndShowSearchBar(){
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Pokemons"
        navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
        
    }
    
    //MARK: - API Call
    
    func fetchPokemons(){
        Service.shared.fetchPokemon { result in
            switch result {
            
            case .success(let fetchedPokemons):
                self.pokemonArray = fetchedPokemons
                self.filteredArray = fetchedPokemons
                self.collectionView.reloadData()
            case .failure(let error):
                print("Error fetching pokemons from server", error)
            }
        }
    }
    

    //MARK: - Helper Functions
    
    func configureViewComponents(){
        
        collectionView.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pokedix"
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        searchBar.sizeToFit()
        searchBar.delegate = self



        
       showSearchIcon()
        
        
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: cellIdentifier)
        //        navigationController?.navigationBar.barStyle = .black
        //        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    func showSearchIcon(){
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector (hideSearchIconAndShowSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .systemPink
        searchBar.showsCancelButton = false
    }
    
    
}

//MARK: - CollectionView DataSource

extension PokedexController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PokedexCell
    
        cell.pokemnon = filteredArray?[indexPath.row]
        return cell
    }
    
}

//MARK: - CollectionView Delegate

extension PokedexController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard filteredArray?[indexPath.row] != nil else {return}
        let selectedPokemon = filteredArray![indexPath.row]
        let detailController = PokemonDetailViewController()
        detailController.detailPokemon = selectedPokemon
        navigationController?.pushViewController(detailController, animated: true)
        
    }
}


extension PokedexController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
}







//MARK: - SearchBar Delegate

extension PokedexController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        showSearchIcon()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filteredArray = pokemonArray
        collectionView.reloadData()
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredArray = []
        if searchText == "" {
            filteredArray = pokemonArray
        }
        guard pokemonArray != nil else {return}
        for pokemon in pokemonArray! {
            if pokemon.name!.lowercased().contains(searchText.lowercased()) {
                filteredArray?.append(pokemon)
            }
        }
        
        collectionView.reloadData()
    }
    
    
    
    
}
