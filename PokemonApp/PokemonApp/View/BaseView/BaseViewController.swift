//
//  BaseViewController.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 7/09/22.
//

import Foundation
import UIKit

internal class BaseViewController : UIViewController{
    
    var colors: AppColors = AppColors()
    var Colors: AppColors {get {return colors}}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = Colors.dark
        
        navigationController?.isNavigationBarHidden = false
        title = "PokemonWiki"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: colors.yellow,
                                                                   NSAttributedString.Key.font: UIFont(name: "Pokemon Solid", size: 26)!]
    }
    
}
