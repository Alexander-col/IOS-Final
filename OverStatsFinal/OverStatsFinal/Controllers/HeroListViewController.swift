//
//  HeroListViewController.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/13/26.
//
//UIKit as term specs
import UIKit


//Display of hero names to have practice screen before API implementation
class HeroListViewController : UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    var heroes: [Hero] = []
    letapriService = OverfastAPIService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Screen will display character in the game known as heroes
        title = "Heroes"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HeroListViewController: UITableViewDelegate
{
    
}

//Data seperation as hero info enters
extension HeroListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HeroCell")
        cell.textLabel?.text = heroes [indexPath.row]
        
        return cell
    }
}
