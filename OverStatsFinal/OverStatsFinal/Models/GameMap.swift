// Author Alexander Colotl
// Created May 2026



import Foundation

//This hold the struct for the detialed screen of a selected Game map to be used for detailed screen
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
