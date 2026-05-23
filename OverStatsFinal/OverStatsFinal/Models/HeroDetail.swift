// Author Alexander Colotl
// Created May 2026

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
//Some heros have more hp on top of base such armor shields on top of health
struct Hitpoints: Codable
{
    let armor: Int
    let health: Int
    let shields: Int
    let total: Int
}
//Heroes hold addtional abltities that vary so simpler to store on a table view
struct HeroAbility: Codable
{
    let name: String
    let description: String?
    let icon: String?
}
