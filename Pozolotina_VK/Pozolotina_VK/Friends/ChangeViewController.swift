//
//  ChangeViewController.swift
//  Pozolotina_VK
//
//  Created by angelina on 20.05.2022.
//

import UIKit

class ChangeViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    var friends = [
        User(image: UIImage(named: "foto")!, name: "Nikita", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!, UIImage(named: "avto")!]),
        User(image: UIImage(named: "foto")!, name: "Stepan", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!, UIImage(named: "avto")!] ),
        User(image: UIImage(named: "ava")!, name: "Anna", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!]),
        User(image: UIImage(named: "ava")!, name: "Angelina", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!]),
        User(image: UIImage(named: "ava")!, name: "Борис", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!]),
        User(image: UIImage(named: "ava")!, name: "Владимир", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!]),
        User(image: UIImage(named: "ava")!, name: "Галина", photos: nil),
        User(image: UIImage(named: "foto")!, name: "Геннадий", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!]),
        User(image: UIImage(named: "ava")!, name: "Влада", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!]),
        User(image: UIImage(named: "ava")!, name: "Зина", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!]),
        User(image: UIImage(named: "ava")!, name: "Лена", photos: [UIImage(named: "foto")!, UIImage(named: "cat")!]),
        User(image: nil, name: "Шамиль", photos: nil)
    ]
    
    
    var avatarsFriendsList: [UIImage?] = [
        UIImage(named: "ava")!,
        UIImage(named: "ava")!
    ]
    
    
    var filterFriends = [User]()
    var sortedFriendsDict: [Character: [User]] = [:]
    
    
    var searchList: [String] = []
    var letersOfNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortedFriendsDict = sortedArray(array: friends)
        

        searchList = friends.map { item in return item.name }
        
        sortCharacterOfNamesAlphabet()
    }
    
    // Здесь создаешь массим из начальных букв юзеров
    func sortCharacterOfNamesAlphabet() {
        var letersSet = Set<Character>()
        letersOfNames = [] // Делаем массив пустым, если будем повтроно запрашивать имена
        // сет из первых букв имени, чтобы не было повторов
        for name in searchList {
            letersSet.insert(name[name.startIndex])
        }
        
        // Заполняем массив из букв имен юзеров
        for leter in letersSet.sorted() {
            letersOfNames.append(String(leter))
        }
    }
    
    
    func sortedArray(array: [User]) -> [Character:[User]] {
        
        var sortDict:[Character:[User]] = [:]
        
        array.forEach {user in
            guard let firstChar = user.name.first else {return}
            
            if var sortedArrayForEachChar = sortDict[firstChar] {
                sortedArrayForEachChar.append(user)
                sortDict[firstChar] = sortedArrayForEachChar.sorted{ $0.name < $1.name }
            } else {
                sortDict[firstChar] = [user]
            }
        }
        return sortDict
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedFriendsDict.keys.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letersOfNames
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keySorted = sortedFriendsDict.keys.sorted()
        return String(keySorted[section])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keySorted = sortedFriendsDict.keys.sorted()
        return sortedFriendsDict[keySorted[section]]!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        
        let firstChar = sortedFriendsDict.keys.sorted()[indexPath.section]
        let users = sortedFriendsDict[firstChar]!
        let user = users[indexPath.row]
        
        var usersRow = [String]()
 
        for user in searchList.sorted() {
            if letersOfNames[indexPath.section].contains(user.first!) {
                usersRow.append(user)
            }
        }
        
        cell.friendsName.text = user.name
        
        for i in 0..<friends.count {
            let value = friends[i]
            if value.name == usersRow[indexPath.row] {
                if value.image == nil {
           
            cell.friendsImageView.avatarImage.image = avatarsFriendsList[indexPath.row]
                } else {
    
                    cell.friendsImageView.avatarImage.image = user.image
                }
            }
        }
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "checkPhoto",
            let destination = segue.destination as? PhotoFriendsCoollectionVC,
            let indexPath = tableView.indexPathForSelectedRow {
        
                let strChar = letersOfNames[indexPath.section]
                let index = Int(indexPath.row)
                let fchar = strChar[0]
                
                    if searchBar.text == "" {
                        let friends = sortedFriendsDict[fchar]![index]
                        destination.friends.append(friends)
                    } else {
                        let arrayOfFriends = friends.filter() { $0.name.lowercased().contains(searchBar.text!.lowercased()) }
                        let friend = arrayOfFriends[index]
                        destination.friends.append(friend)
                        //destination.friends.append(one)
            //destination.friendsName = friends[indexPath.row].name
                    }
    

        }
    }
    
}


extension ChangeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filterFriends = friends
        } else {
            filterFriends = friends.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    
        sortedFriendsDict = sortedArray(array: filterFriends)
        
        tableView.reloadData()
    }
    
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
