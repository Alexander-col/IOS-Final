//
//  GameModeDetailViewController.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/22/26.
//



import UIKit

class GameModeDetailViewController : UIViewController
{
    @IBOutlet weak var screenshotImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var gameMode: GameMode?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Game Mode Details"
        view.backgroundColor = .systemBackground
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
