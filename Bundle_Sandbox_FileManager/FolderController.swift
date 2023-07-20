//
//  FolderController.swift
//  Bundle_Sandbox_FileManager
//
//  Created by Ekaterina Saveleva on 10.07.2023.
//

import UIKit

class FolderController: UITableViewController {
    
    var manager = FolderManager()// отправляет в папку Documents
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Public methods

    @IBAction func pushAddFolderAction(_ sender: Any) {
        manager.addFolder(name: "New Folder")
        tableView.reloadData()
    }
    
    @IBAction func pushAddFileAction(_ sender: Any) {
        manager.addFolder(name: "file.txt")
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return manager.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var item = manager.items[indexPath.row]
        
        var configuration = UIListContentConfiguration.cell()
        configuration.text = item
        configuration.secondaryText = manager.isDerictory(atIndex: indexPath.row) ? "FOLDER" : "File"
        cell.contentConfiguration = configuration

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            manager.deleteItem(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        FolderController.show(in: self, withPath: manager.getFullPath(atIndex: indexPath.row))
    }
    

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension FolderController {
    static func show(in viewController: UIViewController, withPath path: String) {
        let fc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FolderController") as! FolderController
        
        fc.manager = FolderManager(pathForCurrentFolder: path)
        viewController.navigationController?.pushViewController(fc, animated: true)
    }
}

