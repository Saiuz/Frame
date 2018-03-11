//
//  AlbumsViewController.swift
//  Frame
//
//  Created by Matthew Paletta on 2018-03-11.
//  Copyright © 2018 Matthew Paletta. All rights reserved.
//

import UIKit

class AlbumsViewController: UITableViewController {
    
    var  enabled_services = [[Bool]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getServices() -> [String] {
        return ["Facebook"]
    }
    
    func getEnabled() -> [[Bool]] {
        var enabled_services = [[Bool]]()
        let albums = self.getAlbums()
        for al in albums {
            enabled_services.append([Bool](repeating: false, count: al.count))
        }
        if self.enabled_services.count == 0 {
            self.enabled_services = enabled_services
        }
        return self.enabled_services
    }
    
    func getAlbums() -> [[String]] {
        return [["Cover Photos", "Profile Photos", "Mobile Uploads"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.getAlbums().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.getAlbums()[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.getServices()[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumReuseLabel", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = self.getAlbums()[indexPath.section][indexPath.row]
        cell.backgroundColor = UIColor(red: 22.0/255.0, green: 22.0/255, blue: 22.0/255.0, alpha: 1.0)
        cell.textLabel?.textColor = .white
        if self.getEnabled()[indexPath.section][indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Updating: \(self.getAlbums()[indexPath.section][indexPath.row])")
        self.enabled_services[indexPath.section][indexPath.row] = !self.enabled_services[indexPath.section][indexPath.row]
        tableView.reloadData()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
