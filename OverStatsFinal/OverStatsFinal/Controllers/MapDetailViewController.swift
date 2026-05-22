//
//  MapDetailViewController.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/22/26.
//

import UIKit

class MapDetailViewController : UIViewController
{
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var gameModesLabel: UILabel!
    
    var gameMap: GameMap?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Map Details"
        view.backgroundColor = .systemBackground
        
        if let gameMap = gameMap
        {
            nameLabel.text = gameMap.name
            locationLabel.text = gameMap.location ?? "Unknown location"
            
            if let modes = gameMap.gameModes
            {
                gameModesLabel.text = modes.joined(separator: ", ")
            }
            else
            {
                gameModesLabel.text = "No game modes available"
            }
            
            if let screenshot = gameMap.screenshot
            {
                loadImage(from: screenshot)
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
                self.mapImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
