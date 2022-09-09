//
//  Ability.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 8/09/22.
//

import Foundation

struct Ability : Decodable{
    let name: String?
    var effect_entries: Array<Effect>
}

struct Effect : Decodable{
    let effect: String?
    let language: Language?
}

struct Language : Decodable{
    let name: String?
}
