//
//  AllGroups.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit

/// Контроллер экрана сценария "Мои группы"
class AllGroups: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    //возможно не нужное свойство
    var myGroups2 : [Groups] {
        get {
            return allMyGroups
        }
    }
    
    var filteredGroups = [Groups]()
    
    let service = GroupService()
    var groupModel: Resp?
    var allMyGroups = [Groups]()
        
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGroups()
    }
    
        //обновляет страницу при добавлении группы
    override func viewWillAppear(_ animated: Bool) {
        //filteredGroups = myGroups
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
        cell.groupImageView.loadImage(with: filteredGroups[indexPath.row].image)
        
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        // Проверяем идентификатор, чтобы убедиться, что это нужный переход
        if segue.identifier == "addGroup" {
        // Получаем ссылку на контроллер, с которого осуществлен переход
           if let notMyGroupsController = segue.source as? NotMyGroupsController,
                // Получаем индекс выделенной ячейки
            let indexPath = notMyGroupsController.tableView.indexPathForSelectedRow {
               // Получаем группу по индексу
               let group = notMyGroupsController.allGroup[indexPath.row]
                    // Проверяем, что такой группы нет в списке
               if !allMyGroups.contains(where: {$0.name == group.name}) {
                  
                // Добавляем группу в список выбранных групп
                   allMyGroups.append(group)
                
                // Обновляем таблицу
                   tableView.reloadData()
                }
            }
        }
    }
   
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let group = allMyGroups[indexPath.row]
            
            //удаляем группу
            
            allMyGroups.removeAll() {$0.name == group.name}
            
            self.searchBar(searchBar, textDidChange: searchBar.text ?? "")
        }  
    }
    
    // мигание ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension AllGroups: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            
            filteredGroups = allMyGroups
        } else {
            
            filteredGroups = allMyGroups.filter{$0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}

//MARK: - Private
private extension AllGroups {
    func fetchGroups() {
        service.loadGroups { result in
            switch result {
            case .success(let group):
                DispatchQueue.main.async {
                    self.groupModel = group
                    
                    self.allMyGroups = (self.groupModel?.response.items)!
                    
                    self.filteredGroups = self.allMyGroups
                    
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
