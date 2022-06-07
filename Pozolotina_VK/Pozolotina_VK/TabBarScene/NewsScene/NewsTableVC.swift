//
//  NewsTableVC.swift
//  Pozolotina_VK
//
//  Created by angelina on 27.04.2022.
//

import UIKit

var newsCell = [
    News(ava: UIImage(named: "foto")!, name: "Василий Соколов", time: "сегодня в 01:36", text: "Идея, что рынок, достигнув максимума, должен скорректироваться, лежит на поверхности и кажется очевидной, но какие-либо фундаментальные причины для подобного поведения отсутствуют. Более того, с середины прошлого века мы могли наблюдать без малого 1500 случаев, когда рынок устанавливал абсолютный рекорд — примерно каждый 15-й торговый день. При этом серьёзные коррекции за этот период можно пересчитать на пальцах одной руки.", picture: UIImage(named: "foto")!, touches: 5, watches: 236),
    News(ava: UIImage(named: "cat")!, name: "Екатерина Кошкина", time: "15 апреля в 18:45", text: "Некоторые кошки издают звук, подобный бормотанию или щебетанию. Производится он слегка открытой пастью и обозначает приветствие или привлечение внимания.", picture: UIImage(named: "cat")!, touches: 76, watches: 546)]


class NewsTableVC: UITableViewController{

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
        return newsCell.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            preconditionFailure("Error")
        }

        // устанавливаем группу в надпись ячейки
        cell.newsNameLabel.text = newsCell[indexPath.row].name
        cell.newsTimeLabel.text = newsCell[indexPath.row].time
        cell.newsTextLabel.text = newsCell[indexPath.row].text
        cell.newsImage.image = newsCell[indexPath.row].picture
        cell.avaImage.image = newsCell[indexPath.row].ava
        cell.watchCountLabel.text = String(newsCell[indexPath.row].watches)
        cell.countLabel.text = String(newsCell[indexPath.row].touches)

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }



    @IBAction func tapAction(_ sender: UIButton) {
        if let index = tableView.indexPath(for: sender.superview!.superview!.superview as! NewsTableViewCell) {
            newCell.append(newsCell[index.row])
        }
    }

}
