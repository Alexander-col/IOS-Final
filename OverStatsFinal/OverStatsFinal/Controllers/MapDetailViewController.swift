// Author Alexander Colotl
// Created May 2026

import UIKit

//This screen hold the detailed view of a game mode selected via the prior game modes table view
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
        view.backgroundColor = .systemGray6
        mapImageView.layer.borderWidth = 3
        mapImageView.layer.borderColor = UIColor.systemBlue.cgColor
        mapImageView.layer.cornerRadius = 12
        mapImageView.clipsToBounds = true
        mapImageView.contentMode = .scaleAspectFit
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
