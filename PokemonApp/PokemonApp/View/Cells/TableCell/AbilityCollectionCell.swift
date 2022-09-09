//
//  AbilityCollectionCell.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 8/09/22.
//

import UIKit

class AbilityCollectionCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var colors: AppColors = AppColors()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        SetupViews()
    }
    
    private func SetupViews(){
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = colors.grayDark
        containerView.layer.cornerRadius = 20;
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = colors.yellow
        titleLabel.textAlignment = .right
        titleLabel.numberOfLines = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = colors.blueCold
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
        SetConstraints()
    }
    
    private func SetConstraints(){
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.widthAnchor.constraint(equalToConstant: bounds.width),
            containerView.heightAnchor.constraint(equalToConstant: 170),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -80),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -90),
            descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30),
            descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -30),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
        ])
    }

}
