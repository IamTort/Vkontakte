//
//  FriendsController.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

/*import UIKit

class FriendsController: UITableViewController {
    
    var friends = [
        User(image: UIImage(named: "ava")!, name: "Nikita"),
        User(image: UIImage(named: "ava")!, name: "Stepan"),
        User(image: UIImage(named: "ava")!, name: "Anna"),
        User(image: UIImage(named: "ava")!, name: "Angelina")
    ]
    
    var sortedFriends = [Character: [User]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sortedFriends = sort(friends: friends)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    //сортировка друзей
    private func sort(friends: [User]) -> [Character: [User]] {
        
        var friendsDict = [Character: [User]]()
        
        friends.forEach() { friend in
            
            guard let firstChar = friend.name.first else {return}
            
            if var thisCharFriend = friendsDict[firstChar] {
                thisCharFriend.append(friend)
                friendsDict[firstChar] = thisCharFriend
            } else {
                friendsDict[firstChar] = [friend]
            }
            
        }
        return friendsDict
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sortedFriends.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let keysSorted = sortedFriends.keys.sorted()
        let friends = sortedFriends[keysSorted[section]]?.count ?? 0
        
        return friends
    }

    //выводит инфу на экран
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell else {
            preconditionFailure("Error")
        }

        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!
        
        let friend: User = friends[indexPath.row]
        
        cell.friendsName.text = friend.name
        cell.friendsImageView.image =  friend.image

        return cell
    }
    
     //функция добавляет переход через код, а не с помощью сториборда, без него не работает переход
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "checkPhoto", sender: indexPath)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "checkPhoto",
                let destination = segue.destination as? PhotoController,
                   let indexPath = tableView.indexPathForSelectedRow {
                    
                    //destination.friendsName = friends[indexPath.row].name
                    destination.friends.append(friends[indexPath.row])
        }
        
        
        
    }
    
    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedFriends.keys.sorted()[section])
    }
    
    
    
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
*/
