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
}
