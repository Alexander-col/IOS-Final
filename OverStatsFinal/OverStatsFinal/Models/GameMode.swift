// Author Alexander Colotl
// Created May 2026

import Foundation

//This sturct holds the items of what Game mode values will be filled in by the API on game mode detail screen
struct GameMode: Codable
{
    let key: String?
    let name: String
    let description: String?
    let screenshot: String?
}
