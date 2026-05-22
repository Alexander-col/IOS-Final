//
//  MapsViewController.swift
//  OverStatsFinal
//
//  Created by user933335 on 5/22/26.
//

import UIKit

class MapsViewController : UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    var maps: [GameMap] = []
    let apiService = OverfastAPIService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Maps"
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchMaps()
    }
    
    func fetchMaps()
    {
        apiService.fetchMaps
        {
            maps in
            
            DispatchQueue.main.async
            {
                self.maps = maps
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showMapDetail"
        {
            if let detailVC = segue.destination as? MapDetailViewController,
               let selectedMap = sender as? GameMap
            {
                detailVC.gameMap = selectedMap
            }
        }
    }}


extension MapsViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return maps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath)
        
        let map = maps[indexPath.row]
        
        cell.textLabel?.text = map.name
        
        if let location = map.location
        {
            cell.detailTextLabel?.text = location
        }
        else if let modes = map.gameModes
        {
            cell.detailTextLabel?.text = modes.joined(separator: ", ")
        }
        else
        {
            cell.detailTextLabel?.text = "Overwatch Map"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showMapDetail", sender: maps[indexPath.row])
    }
}
