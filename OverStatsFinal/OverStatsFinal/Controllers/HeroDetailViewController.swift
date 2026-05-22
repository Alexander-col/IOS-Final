//
//  HeroDetailViewController.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/13/26.
//

import UIKit

class HeroDetailViewController : UIViewController
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var hero: Hero?
    let apiService = OverfastAPIService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Hero Details"
        view.backgroundColor = .systemBackground
        
        if let hero = hero
        {
            nameLabel.text = hero.name
            roleLabel.text = hero.role.capitalized
            descriptionLabel.text = "Loading..."
            locationLabel.text = "Loading..."
            difficultyLabel.text = "Medium"
            
            loadImage(from: hero.portrait)
            fetchDetailedHeroData(heroKey: hero.key)
            updateFavoriteButton()
            
        }
    }
    func fetchDetailedHeroData(heroKey: String)
    {
        apiService.fetchHeroDetail(heroKey: heroKey)
        {
            heroDetail in
            
            DispatchQueue.main.async
            {
                guard let heroDetail = heroDetail
                else
                {
                    self.descriptionLabel.text = "No description available."
                    self.locationLabel.text = "Unknown location."
                    return
                }
                
                self.descriptionLabel.text = heroDetail.description ?? "No description available."
                self.locationLabel.text = heroDetail.location ?? "Unknown location."
                
                if let totalHealth = heroDetail.hitpoints?.total
                {
                    self.difficultyLabel.text = "Health: \(totalHealth)"
                }
                else
                {
                    self.difficultyLabel.text = "Medium"
                }
            }
        }
    }
    func loadImage(from urlString: String)
    {
        guard let url = URL(string: urlString)
        else
        {
            return
        }
        URLSession.shared.dataTask(with: url)
        {
            data, response, error in
            guard let data = data else
            {
                return
            }
            DispatchQueue.main.async
            {
                self.portraitImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    func updateFavoriteButton()
    {
        guard let hero = hero else
        {
            return
        }
        
        if FavoritesManager.shared.isFavorite(hero)
        {
            favoriteButton.setTitle("Remove from Favorites", for: .normal)
        }
        else
        {
            favoriteButton.setTitle("Add to Favorites", for: .normal)
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton)
    {
        guard let hero = hero else
        {
            return
        }
        
        if FavoritesManager.shared.isFavorite(hero)
        {
            FavoritesManager.shared.removeFavorite(hero)
        }
        else
        {
            FavoritesManager.shared.saveFavorite(hero)
        }
        
        updateFavoriteButton()
    }
}
