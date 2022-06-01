//
//  NotMyGroupsController.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit

class NotMyGroupsController: UITableViewController {

    
    var availableGroup = [
        Group(image: UIImage(named: "ponchik")!, name: "Сочные плюшки"),
        Group(image: UIImage(named: "remont")!, name: "Ремонт и дом"),
        Group(image: UIImage(named: "avto")!, name: "Автотюнинг"),
        Group(image: UIImage(named: "mushrooms")!, name: "Собиратели грибов"),
        Group(image: UIImage(named: "cat")!, name: "Смешные коты"),
        Group(image: UIImage(named: "moms")!, name: "Мамочки Москвы")
        ]
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
        return availableGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoMyGroup", for: indexPath) as! NoMyGroupCell
        
        cell.groupName.text = availableGroup[indexPath.row].name
        cell.availableGroupImageView.image = availableGroup[indexPath.row].image

        return cell
    }
   
}
