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
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    
    var heroes: [Hero] = []
    let apiService = OverfastAPIService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Screen will display character in the game known as heroes
        title = "Heroes"
        
        tableView.delegate = self
        tableView.dataSource = self
        loadHeroes()
    }
    func loadHeroes()
    {
        apiService.fetchHeroes
        {
            heroes in
            DispatchQueue.main.async
            {
                self.heroes = heroes
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showHeroDetail"
        {
            let detailVC = segue.destination as? HeroDetailViewController
            detailVC?.hero = sender as? Hero
        }
    }}

extension HeroListViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "showHeroDetail", sender: heroes[indexPath.row])
    }
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
        
        let hero = heroes[indexPath.row]
        cell.textLabel?.text = hero.name
        cell.detailTextLabel?.text = hero.role.capitalized
        
        
        
        return cell
    }
}
