//
//  FriendsViewController.swift
//  Pozolotina_VK
//
//  Created by angelina on 21.04.2022.
//

import UIKit


class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friends = [
        User(image: UIImage(named: "foto")!, name: "Nikita"),
        User(image: UIImage(named: "foto")!, name: "Stepan"),
        User(image: UIImage(named: "ava")!, name: "Anna"),
        User(image: UIImage(named: "ava")!, name: "Angelina"),
        User(image: UIImage(named: "ava")!, name: "Борис"),
        User(image: UIImage(named: "ava")!, name: "Владимир"),
        User(image: UIImage(named: "ava")!, name: "Галина"),
        User(image: UIImage(named: "foto")!, name: "Геннадий"),
        User(image: UIImage(named: "ava")!, name: "Влада"),
        User(image: UIImage(named: "ava")!, name: "Зина"),
        User(image: UIImage(named: "ava")!, name: "Лена"),
        User(image: nil, name: "Шамиль")
    ]
    
        // пусть пока будет
    var avatarsFriendsList: [UIImage?] = [
        UIImage(named: "ava")!,
        UIImage(named: "ava")!,
        UIImage(named: "ava")!,
        UIImage(named: "ava")!,
        UIImage(named: "ava")!
    ]
    
    var searchList: [String] = []
    var letersOfNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // для поиска
        tableView.dataSource = self
        searchBar.delegate = self
        searchList = friends.map { item in return item.name }
        

        sortCharacterOfNamesAlphabet()
    }

    // MARK: - Table view data source
    
    // поиск по именам
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchList = searchText.isEmpty ? friends.map { item in return item.name } : friends.map { item in return item.name }.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        sortCharacterOfNamesAlphabet() // создаем заново массив заглавных букв для хедера
        tableView.reloadData()
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
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return letersOfNames.count
    }
    
    // буквы для навигации справа
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letersOfNames
    }
    
    // настройка хедера ячеек и добавление букв в него
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        let leter: UILabel = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
        leter.textColor = UIColor.black.withAlphaComponent(0.5)  // прозрачность только надписи
        leter.text = letersOfNames[section]
        leter.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        header.addSubview(leter)
        
        return header
    }

    
    // количество ячеек в секции
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countOfRows = 0
        // сравниваем массив букв и заглавные буквы каждого имени, выводим количество ячеек в соотвествии именам на отдельную букву

        for user in searchList {
            if letersOfNames[section].contains(user.first!) {
               countOfRows += 1
            }
        }
        return countOfRows
    }
    
    // Заполняем ячейки
    var arrayNames = [String]()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получить ячейку класса FriendsCell
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
    
        // Ищем по буквам +  сортируем
        var usersRow = [String]()
 
        for user in searchList.sorted() {
            if letersOfNames[indexPath.section].contains(user.first!) {
                usersRow.append(user)
            }
        }
        cell.friendsName.text = usersRow[indexPath.row]
        
        //Если аватара нет, то ставим системнуюб иконку..
        for i in 0..<friends.count {
            let value = friends[i]
            if value.name == usersRow[indexPath.row] {
                if value.image == nil {
            let avatar = avatarsFriendsList[indexPath.row] //четко по массиву
           
            cell.friendsImageView.avatarImage.image = avatar
                } else {
    
                    cell.friendsImageView.avatarImage.image = value.image
                }
            }
        }
        return cell
        
    }
    
    // убираем постоянно подсвечивание ячейки...
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "checkPhoto",
                 let destination = segue.destination as? PhotoFriendsCoollectionVC,
                 let indexPath = tableView.indexPathForSelectedRow {

                 //destination.friendsName = friends[indexPath.row].name
                 destination.friends.append(friends[indexPath.row])
             }
         }
    
}

