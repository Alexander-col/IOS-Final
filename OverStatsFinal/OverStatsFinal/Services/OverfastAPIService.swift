//
//  OverfastAPIService.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/13/26.
//

//import foundation to use API for Overstats
import Foundation

class OverfastAPIService
{
    func fetchHeroes(completion: @escaping ([Hero]) -> Void)
    {
        let urlString = "https://overfast-api.tekrop.fr/heroes"
        
        guard let url = URL(string: urlString)
        else
        {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url)
        {
            data, response, error in
            if let error = error
            {
                print("API Error:\(error)")
                completion([])
                return
            }
            guard let data = data else
            {
                completion([])
                return
            }
            do
            {
                let heroes = try JSONDecoder().decode([Hero].self, from: data)
                print(heroes.first as Any)
                completion(heroes)
            }
            catch
            {
                print("JSON Error: \(error)")
                completion([])
            }
        }
        task.resume()
        
    }
    func fetchHeroDetail(heroKey: String, completion: @escaping (HeroDetail?) -> Void)
    {
        let urlString = "https://overfast-api.tekrop.fr/heroes/\(heroKey)"
        
        guard let url = URL(string: urlString)
        else
        {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url)
        {
            data, response, error in
            
            if let error = error
            {
                print("Hero detail API error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data
            else
            {
                completion(nil)
                return
            }
            
            do
            {
                let heroDetail = try JSONDecoder().decode(HeroDetail.self, from: data)
                completion(heroDetail)
            }
            catch
            {
                print("Hero detail decode error: \(error)")
                completion(nil)
            }
            
        }.resume()
    }
    func fetchMaps(completion: @escaping ([GameMap]) -> Void)
    {
        guard let url = URL(string: "https://overfast-api.tekrop.fr/maps") else
        {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url)
        {
            data, response, error in
            
            guard let data = data else
            {
                completion([])
                return
            }
            
            do
            {
                let maps = try JSONDecoder().decode([GameMap].self, from: data)
                completion(maps)
            }
            catch
            {
                print("Could not decode maps: \(error)")
                completion([])
            }
        }.resume()
    }}
