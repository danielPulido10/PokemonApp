//
//  ViewModelDetails.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 8/09/22.
//

import Foundation
import Alamofire

internal class ViewModelDetails : BaseViewModel{
    
    var arrayAbilities: [Ability] = [] {
        didSet {
            refreshData()
        }
    }
    
    internal func GetAbilities(arrayAbilities: Array<Abilities>){
        
        for ability in arrayAbilities{
            guard let url = URL(string: "\(baseUrl)ability/\(ability.ability!.name!)/") else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do{
                    AF.request(url, method: .get).validate(statusCode: self.statusOk).responseDecodable(of: Ability.self){
                        response in
                        if var ability = response.value{
                            ability.effect_entries = self.SelectLanguage(arrayIncial: ability.effect_entries)
                            self.arrayAbilities.append(ability)
                        }
                    }
                }
            }.resume()
        }
    }
    
    private func SelectLanguage(arrayIncial:Array<Effect>) -> Array<Effect>{
        
        var arrayFinal: Array<Effect> = Array<Effect>()
        
        for array in arrayIncial{
            if array.language?.name == "en"{
                
                arrayFinal.append(array)
                return arrayFinal
            }
        }
        return arrayFinal
    }
    
}
