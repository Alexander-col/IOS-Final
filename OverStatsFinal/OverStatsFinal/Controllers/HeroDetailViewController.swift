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
    
    var hero: Hero?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Hero Details"
        view.backgroundColor = .systemBackground
        
        if let hero = hero
        {
            nameLabel.text = hero.name
            roleLabel.text = hero.role.capitalized
            loadImage(from: hero.portrait)
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
}
