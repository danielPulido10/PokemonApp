//
//  BaseViewModel.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 8/09/22.
//

import Foundation

internal class BaseViewModel{
    
    internal let baseUrl = "https://pokeapi.co/api/v2/"
    internal let statusOk = 200...299
    
    var refreshData = {() -> () in }
    
}
