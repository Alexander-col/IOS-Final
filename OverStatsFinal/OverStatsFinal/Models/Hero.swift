// Author Alexander Colotl
// Created May 2026

import Foundation


//This struct holds all the items to be used by the Hero 
struct Hero: Codable
{
    let key: String
    let name: String
    let portrait: String
    let role: String
    
    let description: String?
    let location: String?
    
}
