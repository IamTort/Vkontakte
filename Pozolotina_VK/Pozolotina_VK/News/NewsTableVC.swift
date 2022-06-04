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
//        tableView.register(MyCustomHeader.self,
//               forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        
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

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "doComment",
//            let destination = segue.destination as? CommentTableView,
//            let indexPath = tableView.indexPathForSelectedRow {
//
//            //destination.friendsName = friends[indexPath.row].name
//            //destination.newCell.append(newsCell[indexPath.row])
//        }
//    }

    @IBAction func tapAction(_ sender: UIButton) {
        if let index = tableView.indexPath(for: sender.superview!.superview!.superview as! NewsTableViewCell) {
            newCell.append(newsCell[index.row])
        }
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection
//                                section: Int) -> String? {
//       return "Марина Соловьева"
//    }
    
    
//    override func tableView(_ tableView: UITableView,
//            viewForHeaderInSection section: Int) -> UIView? {
//       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
//                   "sectionHeader") as! MyCustomHeader
//       view.title.text = "Василий Соколов"
//       view.image.image = UIImage(named: "foto")
//
//       return view
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
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
