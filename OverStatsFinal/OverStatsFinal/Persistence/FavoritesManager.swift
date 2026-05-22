//
//  FavoritesManager.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/13/26.
//

import Foundation

class FavoritesManager
{
    static let shared = FavoritesManager()
    
    private let favoritesKey = "favoriteHeroes"
    
    private init()
    {
    }
    
    func saveFavorite(_ hero: Hero)
    {
        var favorites = getFavorites()
        
        if favorites.contains(where: { $0.name == hero.name })
        {
            return
        }
        
        favorites.append(hero)
        saveFavorites(favorites)
    }
    
    func removeFavorite(_ hero: Hero)
    {
        var favorites = getFavorites()
        favorites.removeAll { $0.name == hero.name }
        saveFavorites(favorites)
    }
    
    func getFavorites() -> [Hero]
    {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else
        {
            return []
        }
        
        do
        {
            let favorites = try JSONDecoder().decode([Hero].self, from: data)
            return favorites
        }
        catch
        {
            print("Could not load favorites: \(error)")
            return []
        }
    }
    
    func isFavorite(_ hero: Hero) -> Bool
    {
        let favorites = getFavorites()
        return favorites.contains { $0.name == hero.name }
    }
    
    private func saveFavorites(_ favorites: [Hero])
    {
        do
        {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
        catch
        {
            print("Could not save favorites: \(error)")
        }
    }
}
