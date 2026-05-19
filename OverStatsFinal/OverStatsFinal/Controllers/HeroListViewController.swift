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
    var filteredHeroes: [Hero] = []
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
                self.filteredHeroes = heroes
                self.tableView.reloadData()
            }
        }
    }
    
    func filterHeroes()
    {
        let selectedIndex = roleSegmentedControl.selectedSegmentIndex
        
        if selectedIndex == 0
        {
            filteredHeroes = heroes
        }
        else if selectedIndex == 1
        {
            filteredHeroes = heroes.filter
            {
                $0.role.lowercased() == "tank"
            }
        }
        else if selectedIndex == 2
        {
            filteredHeroes = heroes.filter
            {
                $0.role.lowercased() == "damage"
            }
        }
        else if selectedIndex == 3
        {
            filteredHeroes = heroes.filter
            {
                $0.role.lowercased() == "support"
            }
        }
        
        tableView.reloadData()    }
    
    
    @IBAction func roleFilterChanged(_ sender: Any)
    {
        filterHeroes()
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
        performSegue(withIdentifier: "showHeroDetail", sender: filteredHeroes[indexPath.row])
    }
}

//Data seperation as hero info enters
extension HeroListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HeroCell")
        
        let hero = filteredHeroes[indexPath.row]
        cell.textLabel?.text = hero.name
        cell.detailTextLabel?.text = hero.role.capitalized
        
        
        
        return cell
    }
}
