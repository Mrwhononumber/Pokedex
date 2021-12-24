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
    var pokedexViewModelList = PokedexViewModelList()
    var pokemonArray: [PokedexViewModel]?
    let searchBar = UISearchBar()
    var filteredArray: [PokedexViewModel]?
    var index: Int?
    
    
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
        Service.shared.fetchPokemon { [weak self] result in
            switch result {
            case .success(let fetchedPokemons):
                let pokemonViewModels = fetchedPokemons.map({ fetchedPokemon in
                    PokedexViewModel(pokemon: fetchedPokemon)
                })
                guard let self = self else {return}
                self.pokemonArray = pokemonViewModels
                self.filteredArray = pokemonViewModels
                self.pokedexViewModelList.pokedexViewModelArray = pokemonViewModels
                self.pokedexViewModelList.pokedexViewModelFilteredArray = pokemonViewModels
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
        return pokedexViewModelList.pokedexViewModelFilteredArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PokedexCell
        
        cell.pokemnonViewModel = pokedexViewModelList.pokedexViewModelFilteredArray?[indexPath.row]
      
        return cell
    }
    
}

//MARK: - CollectionView Delegate

extension PokedexController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedPokedexViewModel = pokedexViewModelList.pokedexViewModelFilteredArray?[indexPath.row] else {return}
        
        // Pass the selected pokemon to the detail ViewController
        let detailController = PokemonDetailViewController()
        detailController.detailPokedexViewModel = selectedPokedexViewModel
        
        // pass the corresponding evolution pokemons to the detail viewController
        pokedexViewModelList.getEvolutionVM(selectedPoke: selectedPokedexViewModel) {
            detailController.firstEvolutionDetailVM = self.pokedexViewModelList.firstEvolutionVM
            detailController.secondEvolutionDetailVM = self.pokedexViewModelList.seconedEvolutionVM
        }

//        if selectedPokedexViewModel.evolutionIdArray != nil {
//            if selectedPokedexViewModel.evolutionIdArray!.count > 1 {
//                let firstEvolutionVM = pokedexViewModelList.pokedexViewModelFilteredArray?[(selectedPokedexViewModel.evolutionIdArray?[0])!]
//                let seconedEvolutionVM = pokedexViewModelList.pokedexViewModelFilteredArray?[(selectedPokedexViewModel.evolutionIdArray?[1])!]
//                detailController.firstEvolutionDetailVM = firstEvolutionVM
//                detailController.secondEvolutionDetailVM = seconedEvolutionVM
//            } else {
//                let firstEvolutionVM = pokedexViewModelList.pokedexViewModelFilteredArray?[(selectedPokedexViewModel.evolutionIdArray?[0])!]
//                detailController.firstEvolutionDetailVM = firstEvolutionVM
//            }
//        }
  
       

    
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
        pokedexViewModelList.resetSearchToDefault {
            self.collectionView.reloadData()
        }
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokedexViewModelList.searchPokemons(with: searchText) {
            self.collectionView.reloadData()

        }
//        filteredArray = []
//        if searchText == "" {
//            filteredArray = pokemonArray
//        }
//        guard pokemonArray != nil else {return}
//        for pokemon in pokemonArray! {
//            if pokemon.name!.lowercased().contains(searchText.lowercased()) {
//                filteredArray?.append(pokemon)
//            }
//        }
//
//        collectionView.reloadData()
    }
    
    
    
    
}
