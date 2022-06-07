//
//  NotMyGroupsController.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit

class NotMyGroupsController: UITableViewController {

    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            
        }
    }
    
    let service = SearchGroupService()
    var groupModel: Resp?
    
    var allGroup = [Groups]()
    
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
        return allGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoMyGroup", for: indexPath) as! NoMyGroupCell
        
        cell.groupName.text = allGroup[indexPath.row].name
        cell.availableGroupImageView.loadImage(with: allGroup[indexPath.row].image)

        return cell
    }
    
}

//MARK: - UISearchBarDelegate
extension NotMyGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
        } else {
            
            fetchGroups()
        }
        tableView.reloadData()
    }
}

//MARK: - Private
private extension NotMyGroupsController {
    func fetchGroups() {
        service.loadSearchGroups(searchText: searchBar.text) { result in
            switch result {
            case .success(let group):
                DispatchQueue.main.async {
                    self.groupModel = group
                    
                    self.allGroup = group.response.items
                    
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
