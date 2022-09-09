//
//  OneColumnCell.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 9/09/22.
//

import Foundation
import UIKit

internal class OneColumnCell : CollectionViewCell{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CalculateWidthAnchor()
        SetConstraints()
    }

    private func CalculateWidthAnchor(){
        let width = CGFloat(bounds.width)
        widthContanierView = ((width) + 20)
    }

    private func SetConstraints(){

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.widthAnchor.constraint(equalToConstant: widthContanierView),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
    }
    
}
