//
//  AllGroups.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit

extension AllGroups: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            
            filteredGroups = myGroups2
        } else {
            
            filteredGroups = myGroups2.filter{$0.name.contains(searchText)}
        }
        tableView.reloadData()
    }
}


class AllGroups: UITableViewController {

    
    @IBOutlet weak var searchBarGroups: UISearchBar! {
        didSet {
            searchBarGroups.delegate = self
            
        }
    }
    
    var myGroups = [
        Group(image: UIImage(named: "bigcar")!, name: "Дальнобойщики"),
        Group(image: UIImage(named: "cat")!, name: "Смешные коты"),
        Group(image: UIImage(named: "goldring")!, name: "Путешествия по Золотому кольцу"),
        Group(image: UIImage(named: "cowgirl")!, name: "Дородные доярки"),
    ]
    
    var myGroups2 : [Group] {
        get {
            return myGroups
        }
    }
    var filteredGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredGroups = myGroups
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //получаем ячейку из пула
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupsCell else {
            preconditionFailure("Error")
        }

        // устанавливаем группу в надпись ячейки
        cell.groupName.text = filteredGroups[indexPath.row].name
        cell.groupImageView.image = filteredGroups[indexPath.row].image
        
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        // Проверяем идентификатор, чтобы убедиться, что это нужный переход
        if segue.identifier == "addGroup" {
        // Получаем ссылку на контроллер, с которого осуществлен переход
           if let notMyGroupsController = segue.source as? NotMyGroupsController,
                // Получаем индекс выделенной ячейки
            let indexPath = notMyGroupsController.tableView.indexPathForSelectedRow {
               // Получаем город по индексу
               let group = notMyGroupsController.availableGroup[indexPath.row]
                    // Проверяем, что такого города нет в списке
               if !myGroups.contains(where: {$0.name == group.name}) {
                  
                // Добавляем город в список выбранных городов
                   myGroups.append(group)
                
                // Обновляем таблицу
                   tableView.reloadData()
                }
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }  
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*v
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
