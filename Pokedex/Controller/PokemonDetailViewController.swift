//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Basem El kady on 12/13/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    
    //MARK: - Properties
  
    var detailPokemon: Pokemon!{ didSet {
        guard detailPokemon != nil else { return }
        guard detailPokemon?.attack != nil else { return }
        guard detailPokemon?.height != nil else { return }
        guard detailPokemon?.image != nil else { return }
        guard detailPokemon?.imageUrl != nil else { return }
        guard detailPokemon?.name != nil else { return }
        guard detailPokemon?.description != nil else { return }
        guard detailPokemon?.type != nil else { return }
        guard detailPokemon?.weight != nil else { return }
        
        imageView.image = detailPokemon.image
        PokemonInfoLabel.text = detailPokemon.description
        configureLabel(label: attackLabel, title: "Attack", details: "\(detailPokemon.attack!)")
        configureLabel(label: heightLabel, title: "Height", details: "\(detailPokemon.height!)")
        configureLabel(label: typeLabel, title: "Type", details: "\(detailPokemon.type!)")
        configureLabel(label: defenseLabel, title: "Defense", details: "\(detailPokemon.defense!)")
        configureLabel(label: weightLabel, title: "Weight", details: "\(detailPokemon.weight!)")
        configureLabel(label: pokedexIdLabel, title: "Pokedex ID", details: "\(detailPokemon.id!)")
        

        
    }}
    
    let imageView: UIImageView = {
     let iv = UIImageView()
        iv.backgroundColor = .systemGroupedBackground
        iv.contentMode = .scaleAspectFit
        
       return iv
        
    }()
    let PokemonInfoLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    let typeLabel:UILabel = {
       let label = UILabel()
       return label
    }()
    let attackLabel:UILabel = {
       let label = UILabel()
        return label
    }()
    let defenseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    let heightLabel:UILabel = {
       let label = UILabel()
        return label
    }()
    let weightLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right

        return label
    }()
    let pokedexIdLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right

        return label
    }()
    let sepratorView: UIView = {
       let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
        
    }()
    let seconedSepratorView: UIView = {
       let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
        
    }()
    
    
    
    
//MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        downloadPokemonImage()

    }
    
    //MARK: - Helper Functions
    
   private func configureViewComponents() {
          setupViewContollerUI()
          setupViewsAutoLayout()

    }
    
    private func setupViewContollerUI() {
        navigationItem.title = detailPokemon.name?.capitalized
        view.backgroundColor = .systemBackground
    }
    
  
    
    private func setupViewsAutoLayout() {
        
        view.clipsToBounds = true
        
        view.addSubview(imageView)
        imageView.backgroundColor = .clear
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 180)
     
        view.addSubview(PokemonInfoLabel)
        PokemonInfoLabel.anchor(top: imageView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 150)

        view.addSubview(attackLabel)
        attackLabel.anchor(top: PokemonInfoLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 140, height: 22)
        
        view.addSubview(heightLabel)
        heightLabel.anchor(top: attackLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 140, height: 20)
        
        view.addSubview(typeLabel)
        typeLabel.anchor(top: heightLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 140, height: 20)
        
        view.addSubview(defenseLabel)
        defenseLabel.anchor(top: PokemonInfoLabel.bottomAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 140, height: 20)
        
        view.addSubview(weightLabel)
        weightLabel.anchor(top: defenseLabel.bottomAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 140, height: 20)
        
        view.addSubview(pokedexIdLabel)
        pokedexIdLabel.anchor(top: weightLabel.bottomAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 140, height: 20)
        
        view.addSubview(sepratorView)
        sepratorView.anchor(top: attackLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 5, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 1)
        
        view.addSubview(seconedSepratorView)
        seconedSepratorView.anchor(top: heightLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 5, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 1)
        
    }
    
  
    private func configureLabel(label: UILabel, title: String, details: String) {
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(title): ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.systemPink]))
        attributedText.append(NSAttributedString(string: "\(details)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        label.attributedText = attributedText
    }
    
   private func downloadPokemonImage(){
        Service.shared.fetchImage(url: (detailPokemon?.imageUrl) ?? "") { result in
            switch result {
            
            case .success(let fetchedImage):
                self.detailPokemon?.image = fetchedImage
                
            case .failure(let error):
                print ("Error happened while downloading the Image", error)
            }
        }
    }
    



}

