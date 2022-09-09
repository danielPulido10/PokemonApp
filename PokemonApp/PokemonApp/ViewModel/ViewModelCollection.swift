//
//  ViewModelCollection.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 8/09/22.
//

import Foundation
import Alamofire
import UIKit

internal class ViewModelCollection : BaseViewModel{
    
    static let shared = ViewModelCollection()
    
    var arrayPokemon: [Pokemon] = [] {
        didSet {
            refreshData()
        }
    }
    
    var dividerCell: CGFloat = 2
    
    var nameButton: String? = "Una columna"
    
    internal func GetPokemons(first:Int, last:Int){
        
        arrayPokemon = []
        for idPokemon in first...last{
            guard let url = URL(string: "\(baseUrl)pokemon/\(idPokemon)/") else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do{
                    AF.request(url, method: .get).validate(statusCode: self.statusOk).responseDecodable(of: Pokemon.self){
                        response in
                        if let pokemons = response.value{
                            self.arrayPokemon.append(pokemons)
                        }
                    }
                }
            }.resume()
        }
    }
    
    internal func ChangeCell(){
        if dividerCell == 2{
            dividerCell = 1
            nameButton = "Dos columnas"
        }else{
            dividerCell = 2
            nameButton = "Una columna"
            
        }
    }
}
