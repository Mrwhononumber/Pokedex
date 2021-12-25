//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Basem El kady on 12/13/21.
//

import UIKit
import SDWebImage

class PokemonDetailViewController: UIViewController {
    
    
    //MARK: - Properties
    var firstEvolutionDetailVM: PokedexViewModel?
    var secondEvolutionDetailVM: PokedexViewModel?
    var detailPokedexViewModel: PokedexViewModel!{ didSet {
        guard detailPokedexViewModel != nil else { return }
        guard detailPokedexViewModel?.attack != nil else { return }
        guard detailPokedexViewModel?.height != nil else { return }
        guard detailPokedexViewModel?.imageUrl != nil else { return }
        guard detailPokedexViewModel?.name != nil else { return }
        guard detailPokedexViewModel?.description != nil else { return }
        guard detailPokedexViewModel?.type != nil else { return }
        guard detailPokedexViewModel?.weight != nil else { return }
        
  
        PokemonInfoLabel.text = detailPokedexViewModel.description
        evolutionLabel.text = detailPokedexViewModel.evolutionLabel
        configureLabel(label: attackLabel, title: "Attack", details: "\(detailPokedexViewModel.attack!)")
        configureLabel(label: heightLabel, title: "Height", details: "\(detailPokedexViewModel.height!)")
        configureLabel(label: typeLabel, title: "Type", details: "\(detailPokedexViewModel.type!.capitalized)")
        configureLabel(label: defenseLabel, title: "Defense", details: "\(detailPokedexViewModel.defense!)")
        configureLabel(label: weightLabel, title: "Weight", details: "\(detailPokedexViewModel.weight!)")
        configureLabel(label: pokedexIdLabel, title: "Pokedex ID", details: "\(detailPokedexViewModel.id!)")
        

        
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
    
    let evolutionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
//        label.text = "Possible evolution"
        return label
    }()
    
    let evolutionFirstImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    
    let evolutionSecondImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    
    
//MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewComponents()
        updateImages()
       
    }
 
    
    
    //MARK: - Helper Functions
    
   private func configureViewComponents() {
          setupViewContollerUI()
          setupViewsAutoLayout()

    }
    
    private func setupViewContollerUI() {
        navigationItem.title = detailPokedexViewModel.name?.capitalized
        view.backgroundColor = .systemBackground
    }
    

    
  
    
    private func setupViewsAutoLayout() {
        
        view.clipsToBounds = true
        
        view.addSubview(imageView)
        imageView.backgroundColor = .clear
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: view.frame.height/6)
     
        view.addSubview(PokemonInfoLabel)
        PokemonInfoLabel.anchor(top: imageView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 150)

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
        
        view.addSubview(evolutionLabel)
        evolutionLabel.anchor(top: typeLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 30)
        
        view.addSubview(evolutionFirstImage)
        evolutionFirstImage.anchor(top: evolutionLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 80, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        
        view.addSubview(evolutionSecondImage)
        evolutionSecondImage.anchor(top: evolutionLabel.bottomAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 80, width: 80, height: 80)
        
        
        
    }
    
    private func updateImages() {
        imageView.sd_setImage(with: URL(string: (detailPokedexViewModel?.imageUrl!)!))
        imageView.sd_imageTransition = .fade
        
        guard ((firstEvolutionDetailVM?.imageUrl) != nil) else {return}
        evolutionFirstImage.sd_setImage(with: URL(string: (firstEvolutionDetailVM?.imageUrl)!))
      
    
        guard ((secondEvolutionDetailVM?.imageUrl) != nil) else {return}
       
        evolutionSecondImage.sd_setImage(with: URL(string: (secondEvolutionDetailVM?.imageUrl)!))
        
    }


  
    private func configureLabel(label: UILabel, title: String, details: String) {
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(title): ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.systemPink]))
        attributedText.append(NSAttributedString(string: "\(details)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        label.attributedText = attributedText
    }
    

}

