//
//  NotMyGroupsController.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit

class AllGroupsController: UITableViewController {

    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            
        }
    }
    
    let service = SearchGroupService()
    var groupModel: ResponseGroup?
    
    var allGroups = [Groups]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoMyGroup", for: indexPath) as! AllGroupCell
        
        cell.groupName.text = allGroups[indexPath.row].name
        cell.availableGroupImageView.loadImage(with: allGroups[indexPath.row].image)

        return cell
    }
    
}

//MARK: - UISearchBarDelegate
extension AllGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
        } else {
            
            fetchGroups()
        }
        tableView.reloadData()
    }
}

//MARK: - Private
private extension AllGroupsController {
    func fetchGroups() {
        service.loadSearchGroups(searchText: searchBar.text) { result in
            switch result {
            case .success(let group):
                DispatchQueue.main.async {
                    self.groupModel = group
                    
                    self.allGroups = group.response.items
                    
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
