//  Author: Alexander Colotl
// Created May 2026

import UIKit
//Overall this screen goes over game mode chosen from the game modes display table view piror
class GameModeDetailViewController : UIViewController
{
    //IBOutlets created to connect conteents of page such as mode image, game mode name and describing it
    @IBOutlet weak var screenshotImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //Stores game mode chosen from prior display table view
    var gameMode: GameMode?
    
    //func sets up decor of screen with border added to image, defulat messages and background color
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Game Mode Details"
        view.backgroundColor = .systemGray6
        screenshotImageView.layer.borderWidth = 3
        screenshotImageView.layer.borderColor = UIColor.systemBlue.cgColor
        screenshotImageView.layer.cornerRadius = 12
        screenshotImageView.clipsToBounds = true
        screenshotImageView.contentMode = .scaleAspectFit
        if let gameMode = gameMode
        {
            nameLabel.text = gameMode.name
            descriptionLabel.text = gameMode.description ?? "No description available."
            
            if let screenshot = gameMode.screenshot
            {
                loadImage(from: screenshot)
            }
        }
    }
    //Loads imagefrom API url string 
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
                self.screenshotImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
