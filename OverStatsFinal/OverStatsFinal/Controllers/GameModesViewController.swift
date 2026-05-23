// Author Alexander Colotl
// Created May 2026
import UIKit

//This screen shoes list Overwatch games modes via API
class GameModesViewController : UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    var gameModes: [GameMode] = []
    let apiService = OverfastAPIService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Game Modes"
        view.backgroundColor = .systemGray6
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchGameModes()
    }
    
    func fetchGameModes()
    {
        apiService.fetchGameModes
        {
            gameModes in
            
            DispatchQueue.main.async
            {
                self.gameModes = gameModes
                self.tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showGameModeDetail"
        {
            if let detailVC = segue.destination as? GameModeDetailViewController,
               let selectedGameMode = sender as? GameMode
            {
                detailVC.gameMode = selectedGameMode
            }
        }
    }
}

extension GameModesViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return gameModes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameModeCell", for: indexPath)
        
        let gameMode = gameModes[indexPath.row]
        cell.textLabel?.text = gameMode.name
        cell.detailTextLabel?.text = gameMode.description ?? "Overwatch game mode"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showGameModeDetail", sender: gameModes[indexPath.row])
    }
}
