//
//  CommentTableView.swift
//  Pozolotina_VK
//
//  Created by angelina on 28.04.2022.
//

import UIKit
var newCell = [News]() 
class CommentTableView: UITableViewController {

    
    //var newCell = [News]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MyCellForNews", bundle: nil), forCellReuseIdentifier: "MyCellForNews")
    }

    override func viewWillDisappear(_ animated: Bool) {
        newCell.removeAll()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellForNews", for: indexPath) as? MyCellForNews else {
            preconditionFailure("Error")
        }

        cell.nameLabel.text = newCell[indexPath.row].name
        cell.timeLabel.text = newCell[indexPath.row].time
        cell.avaImage.image = newCell[indexPath.row].ava
        cell.mainTextLabel.text = newCell[indexPath.row].text
        cell.mainImage.image = newCell[indexPath.row].picture
        cell.likeLabel.text = String(newCell[indexPath.row].touches)
        cell.viewLabel.text = String(newCell[indexPath.row].watches)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}
