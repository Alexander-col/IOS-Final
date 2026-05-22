//
//  FavoritesViewController.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/21/26.
//

import UIKit

class FavoritesViewController : UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteHeroes: [Hero] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Favorites"
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        favoriteHeroes = FavoritesManager.shared.getFavorites()
        tableView.reloadData()
    }
}

extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return favoriteHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        
        let hero = favoriteHeroes[indexPath.row]
        cell.textLabel?.text = hero.name
        cell.detailTextLabel?.text = hero.role.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
