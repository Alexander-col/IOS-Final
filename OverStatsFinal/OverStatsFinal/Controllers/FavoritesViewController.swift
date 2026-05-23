import UIKit

//Screen will show all of the favorite heros as the ordered stareed, if not defualt message
class FavoritesViewController : UIViewController
{
    //connections, table view for selcted favorite heroes if not, then defualt message
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyFavoritesLabel: UILabel!
    var favoriteHeroes: [Hero] = []
    
    //function for screen setup color display connection of table view
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Favorites"
        view.backgroundColor = .systemGray6
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    //func checks upon favorites array to update heroes from hero cell display to favorites
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        favoriteHeroes = FavoritesManager.shared.getFavorites()
        tableView.reloadData()
        
        updateEmptyState()
    }
    //func checks for segue going hero detial screen up selection of hero
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showFavoriteDetail"
        {
            let selectedHero = sender as? Hero
            
            if let detailVC = segue.destination as? HeroDetailViewController
            {
                detailVC.hero = selectedHero
            }
            else if let navController = segue.destination as? UINavigationController,
                    let detailVC = navController.topViewController as? HeroDetailViewController
            {
                detailVC.hero = selectedHero
            }
        }
    }
    //When favorite is picked and array empty default emepty label goes away to show table view of favorites
    func updateEmptyState()
    {
        if favoriteHeroes.isEmpty
        {
            emptyFavoritesLabel.isHidden = false
            tableView.isHidden = true
        }
        else
        {
            emptyFavoritesLabel.isHidden = true
            tableView.isHidden = false
        }
    }}
//Extension takes care of table set up once heros are in favorite array simllar hero view display
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
        performSegue(withIdentifier: "showFavoriteDetail", sender: favoriteHeroes[indexPath.row])
    }
    

}

