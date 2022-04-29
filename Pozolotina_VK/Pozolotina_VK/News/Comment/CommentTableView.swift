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

        print(newCell.count)
        cell.nameLabel.text = newCell[indexPath.row].name
        cell.timeLabel.text = newCell[indexPath.row].time
        cell.avaImage.image = newCell[indexPath.row].ava
        cell.mainTextLabel.text = newCell[indexPath.row].text
        cell.mainImage.image = newCell[indexPath.row].picture
        cell.likeLabel.text = String(newCell[indexPath.row].touches)
        cell.viewLabel.text = String(newCell[indexPath.row].watches)
        // устанавливаем группу в надпись ячейки
//        cell.newsNameLabel.text = newsCell[indexPath.row].name
//        cell.newsTimeLabel.text = newsCell[indexPath.row].time
//        cell.newsTextLabel.text = newsCell[indexPath.row].text
//        cell.newsImage.image = newsCell[indexPath.row].picture
//        cell.avaImage.image = newsCell[indexPath.row].ava
//        cell.watchCountLabel.text = String(newsCell[indexPath.row].watches)
//        cell.countLabel.text = String(newsCell[indexPath.row].touches)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}
