//
//  PokedexCell.swift
//  Pokedex
//
//  Created by Basem El kady on 12/11/21.
//

import UIKit
import SDWebImage

class PokedexCell: UICollectionViewCell {
    
    //MARK: - Properties
   
    var pokemnon: Pokemon? { didSet {
        nameLabel.text = pokemnon?.name?.capitalized ?? "N/A"
        fetchPokemonImages()
        
        
          
        
    }}
   
    
    
    
    let imageView: UIImageView = {
     let iv = UIImageView()
        iv.backgroundColor = .systemGroupedBackground
        iv.contentMode = .scaleAspectFit
        
       return iv
        
    }()
    
    lazy var nameContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .mainPink()
        view.addSubview(nameLabel)
        nameLabel.center(inView: view)
        return view
        
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "pikachu"
        return label
        
    }()
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    
    func configureViewComponents() {
        
        layer.cornerRadius = 10
        clipsToBounds = true
       
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.frame.height - 32)
     
        addSubview(nameContainerView)
        nameContainerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 32)
        
        backgroundColor = .cyan
        layer.borderColor = CGColor(red: 232/255, green: 231/255, blue: 73/255, alpha: 1)
        layer.borderWidth = 0.15
        
    }
    
    
    func fetchPokemonImages() {
        imageView.sd_setImage(with: URL(string: (pokemnon?.imageUrl!)!))
        imageView.sd_imageTransition = .fade
    }
    
   
    
    
//    func downloadPokemonImage(){
//
//        guard pokemnon!.imageUrl != nil else {return}
//
//        Service.shared.fetchImage(url: (pokemnon?.imageUrl)!) { result in
//            switch result {
//
//            case .success(let fetchedImages):
//                self.pokemnon?.image = fetchedImages
//
//            case .failure(let error):
//                print ("Error fetching images", error)
//            }
//        }
//
//        }
    
}


