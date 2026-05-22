//
//  GameMap.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/22/26.
//

import Foundation

struct GameMap: Codable
{
    let name: String
    let screenshot: String?
    let gameModes: [String]?
    let location: String?
    
    enum CodingKeys: String, CodingKey
    {
        case name
        case screenshot
        case gameModes = "gamemodes"
        case location
    }
}
