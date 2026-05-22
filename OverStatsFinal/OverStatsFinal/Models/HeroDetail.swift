//
//  HeroDetail.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/13/26.
//
//Adtional file need due to API's {key} on hero details
import Foundation

struct HeroDetail: Codable
{
    let name: String
    let description: String?
    let portrait: String
    let role: String
    let location: String?
    let hitpoints: Hitpoints?
    let abilities: [HeroAbility]?
    
}

struct Hitpoints: Codable
{
    let armor: Int
    let health: Int
    let shields: Int
    let total: Int
}

struct HeroAbility: Codable
{
    let name: String
    let description: String?
    let icon: String?
}
