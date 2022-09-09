//
//  CollectionViewCell.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 7/09/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var namePokemonLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    private let colors: AppColors = AppColors()
    internal var widthContanierView : CGFloat = 0
    
    private var viewModelCollection = ViewModelCollection.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codç
        SetupViews()
    }
    
    private func SetupViews(){
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = colors.dark
        containerView.layer.cornerRadius = 20
        
        pokemonImageView.image = UIImage(named: "ic_pokemon")
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.layer.cornerRadius = 20;
        pokemonImageView.backgroundColor = colors.grayDark
        
        namePokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        namePokemonLabel.textAlignment = .center
        namePokemonLabel.numberOfLines = 0
        namePokemonLabel.font = UIFont(name: "SF Mono", size: 18)
        namePokemonLabel.textColor = colors.blueCold
        
        SetConstraints()
    }
    
    private func SetConstraints(){
        
        NSLayoutConstraint.activate([
            pokemonImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            pokemonImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        NSLayoutConstraint.activate([
            namePokemonLabel.centerXAnchor.constraint(equalTo: pokemonImageView.centerXAnchor),
            namePokemonLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 10),
        ])
    }

}
