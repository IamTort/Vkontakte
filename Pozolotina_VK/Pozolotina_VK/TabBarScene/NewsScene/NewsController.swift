//
//  NewsController.swift
//  Pozolotina_VK
//
//  Created by angelina on 26.07.2022.
//

import UIKit

enum Choise {
    case top, text, image, bottom, none
}

class NewsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return newsCell.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 4
//        убираем секции
//        if newsCell[section].text == nil { number -= 1 }
//        if newsCell[section].picture == nil { number -= 1 }
        return number
    }

//    поставить высоту ячейки в коде
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var news = newsCell[indexPath.section]
//        if news.text?.isEmpty ?? false && indexPath.row == 1 {
//            return 0
//        }
//
//        return 200
//    }
    
    var indexOfCell: Choise = .none
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let news = newsCell[indexPath.section]
        
//        switch indexPath.row {
//        case 0:
//            indexOfCell = .top
//        case 1:
//            indexOfCell = news.text == nil ? .image : .text
//        case 2:
//            indexOfCell = news.picture == nil || news.text == nil ? .bottom : .image
//        case 3:
//            indexOfCell = .bottom
//        default:
//            indexOfCell = .none
//        }
//
//        switch indexOfCell {
//        case .top:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as? AuthorCell else {return UITableViewCell()}
//            cell.nicknameLabel.text = news.name
//            cell.timeLabel.text = news.time
//            return cell
//        case .text:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? TextCell else {return UITableViewCell()}
//            cell.textLabl.text = news.text
//            return cell
//        case .image:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell else {return UITableViewCell()}
//            cell.photoImage.image = news.picture
//            return cell
//        case .bottom:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "likeCell", for: indexPath) as? LikeAndCommentCell else {return UITableViewCell()}
//            return cell
//        case .none:
//            let cell = UITableViewCell()
//            return cell
//        }
        
//      распихиваем инфу по ячейкам
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as? AuthorCell else { return UITableViewCell() }
            cell.avatarImage.image = news.ava
            cell.nicknameLabel.text = news.name
            cell.timeLabel.text = news.time
            cell.avatarImage.image = news.ava
            return cell
        }
        else if indexPath.row == 1 && news.text != nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? TextCell else { return UITableViewCell() }
            cell.textLabl.text = news.text
            return cell
        }
        else if indexPath.row == 2 && news.picture != nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell else { return UITableViewCell() }
            cell.photoImage.image = news.picture
            return cell
        }
        else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "likeCell", for: indexPath) as? LikeAndCommentCell else { return UITableViewCell() }
            //set the data here
            return cell
        } else {
            let cell = UITableViewCell()
            return cell
        }
    }
    
    //        мигание
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
