//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 6/09/22.
//

import Foundation

struct Pokemon: Decodable{
    
    let name: String?
    let description: String?
    let abilities: Array<Abilities>?
    let sprites: Sprits?
    let moves: Array<Moves>?
}

struct Sprits: Decodable{
    let front_default: String?
}

struct Abilities: Decodable{
    let ability: PokemonAbility?
}

struct PokemonAbility: Decodable{
    let name: String?
}

struct Moves: Decodable{
    let move: PokemonMove?
}

struct PokemonMove: Decodable{
    let name: String?
}
