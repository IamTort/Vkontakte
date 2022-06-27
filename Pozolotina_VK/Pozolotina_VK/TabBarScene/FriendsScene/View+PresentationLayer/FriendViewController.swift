//
//  ChangeViewController.swift
//  Pozolotina_VK
//
//  Created by angelina on 20.05.2022.
//

import UIKit
import RealmSwift

/// Контроллер экрана сценария "Друзья"
class FriendViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    var avatarsFriendsList: [UIImage?] = [
        UIImage(named: "ava")!,
        UIImage(named: "ava")!
    ]
    
    let service = FriendService()
    var userModel = [UserDto?]()
    var filterFriends = [User]()
    var sortedFriendsDict: [Character: [User]] = [:]
    
    
    var searchList: [String] = []
    var letersOfNames: [String] = []
    var allUsers = [User]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
    }
    
    // Здесь создаешь массив из начальных букв юзеров
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
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
        
        if user.image != nil {
            cell.friendsImageView.avatarImage.loadImage(with: user.image)
        } else {
            cell.friendsImageView.avatarImage.image = avatarsFriendsList[0]
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
                destination.friendId = String(friends.id)
            } else {
                let arrayOfFriends = allUsers.filter() { $0.name.lowercased().contains(searchBar.text!.lowercased()) }
                let friend = arrayOfFriends[index]
                destination.friendId = String(friend.id)
            }
        }
    }
    
}


//MARK: - Private
private extension FriendViewController {
    func fetchUser() {
        service.loadUsers { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.userModel = user
                    //тут фильтруется и кладется в массив filtUser
                    self.allUsers = self.userModel
                        .filter( { $0?.firstName != "DELETED" } )
                        .map({ user in
                            User(name: (user?.firstName ?? "") + " " + (user?.lastName ?? "") , image: user?.photoUri, id: user?.id)
                        })
                                     
                    //print("usermodel \(self.userModel)")
                    
                    self.sortedFriendsDict = self.sortedArray(array: self.allUsers)
                    
                    self.searchList = self.allUsers.map({$0.name})
                    self.sortCharacterOfNamesAlphabet()
                    
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


//MARK: - UISearchBarDelegate
extension FriendViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filterFriends = allUsers
        } else {
            filterFriends = allUsers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
        sortedFriendsDict = sortedArray(array: filterFriends)
        
        tableView.reloadData()
    }
}
