// Author Alexander Colotl
// Created May 2026
import UIKit


//Display of hero names to have practice screen before API implementation
class HeroListViewController : UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    //vars to display heros in ergular or in cased applied filtered, as well as saving API as var
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
        searchBar.delegate = self
        
        roleSegmentedControl.selectedSegmentIndex = 0
        
        loadHeroes()
    }
    
    //loading heroes via API service
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
    //filter heroes now works with segments and look-up words
    func filterHeroes()
    {
        let selectedIndex = roleSegmentedControl.selectedSegmentIndex
        let searchText = searchBar.text?.lowercased() ?? ""
        var roleFilteredHeroes = heroes
        
        if selectedIndex == 1
        {
            roleFilteredHeroes = heroes.filter { $0.role.lowercased() == "tank" }
        }
        else if selectedIndex == 2
        {
            roleFilteredHeroes = heroes.filter { $0.role.lowercased() == "damage" }
        }
        else if selectedIndex == 3
        {
            roleFilteredHeroes = heroes.filter { $0.role.lowercased() == "support" }
        }
        
        if searchText.isEmpty
        {
            filteredHeroes = roleFilteredHeroes
        }
        else
        {
            filteredHeroes = roleFilteredHeroes.filter
            {
                $0.name.lowercased().contains(searchText)
            }
        }
        
        tableView.reloadData()    }
    
    //Connecting to actually search bar in app for inputs and look-ups
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


extension HeroListViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        filterHeroes()
    }
}
