//
//  AllGroups.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit

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
        
    }
    
    
        //обновляет страницу при добавлении группы
    override func viewWillAppear(_ animated: Bool) {
        filteredGroups = myGroups
        tableView.reloadData()
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
   
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let group = myGroups[indexPath.row]
            
            //удаляем группу
            
            myGroups.removeAll() {$0.name == group.name}
            
            self.searchBar(searchBarGroups, textDidChange: searchBarGroups.text ?? "")
            
        }  
    }
}

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
