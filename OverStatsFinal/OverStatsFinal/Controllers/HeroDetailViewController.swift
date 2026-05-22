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
    @IBOutlet weak var abilitiesTableView: UITableView!
    
    
    var hero: Hero?
    let apiService = OverfastAPIService()
    var abilities: [HeroAbility] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Hero Details"
        view.backgroundColor = .systemBackground
        
        abilitiesTableView.delegate = self
        abilitiesTableView.dataSource = self
        portraitImageView.layer.borderWidth = 3
        portraitImageView.layer.borderColor = UIColor.systemBlue.cgColor
        portraitImageView.layer.cornerRadius = 12
        portraitImageView.clipsToBounds = true
        portraitImageView.contentMode = .scaleAspectFit
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
                
                self.abilities = heroDetail.abilities ?? []
                self.abilitiesTableView.reloadData()
                
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
            favoriteButton.setTitle("★", for: .normal)
        }
        else
        {
            favoriteButton.setTitle("☆", for: .normal)
        }
        
        favoriteButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
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

extension HeroDetailViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return abilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityCell", for: indexPath)
        
        let ability = abilities[indexPath.row]
        
        cell.textLabel?.text = ability.name
        cell.detailTextLabel?.text = ability.description ?? "No description available."
        cell.detailTextLabel?.numberOfLines = 2
        cell.imageView?.image = UIImage(systemName: "star")
        
        if let iconString = ability.icon,
           let iconURL = URL(string: iconString)
        {
            URLSession.shared.dataTask(with: iconURL)
            {
                data, response, error in
                
                guard let data = data else
                {
                    return
                }
                
                DispatchQueue.main.async
                {
                    cell.imageView?.image = UIImage(data: data)
                    cell.setNeedsLayout()
                }
            }.resume()
        }
        
        return cell
    }
}
