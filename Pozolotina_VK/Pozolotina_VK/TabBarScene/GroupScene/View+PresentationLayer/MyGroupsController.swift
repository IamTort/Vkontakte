//
//  AllGroups.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit
import RealmSwift
import FirebaseDatabase

/// Контроллер экрана сценария "Мои группы"
class MyGroupsController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    //возможно не нужное свойство
    var myGroups2 : [Groups] {
        get {
            return myGroups
        }
    }
    
    var filteredGroups = [Groups]()
    
    let service = GroupService()
    var groupModel = [Groups?]()
    var myGroups = [Groups]()
    
    //
    private let realmService = RealmCacheService()
//    это база реалм и мы достаем из нее данные
    private var groupResponse: Results<Groups>? {
        realmService.read(Groups.self)
    }
    //токен, который генерируется при подписке на обновление
    private var token: NotificationToken?
    
        
    private var ref = Database.database().reference(withPath: "Communities")
    private var firebaseCommunities: [FirebaseCommunities] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotificationToken()
        loadGroup()
        ref.observe(.value, with: { snapshot in
            var groups: [FirebaseCommunities] = []
//просматриваем все дочернии снимки базы
            snapshot.children.forEach { child in
                if let snapshot = child as? DataSnapshot,
                   let group = FirebaseCommunities(snapshot: snapshot) {
                    groups.append(group)
                }
            }
            groups.forEach { print($0.groupName) }
        })
    }
    
        //обновляет страницу при добавлении группы, стало не актуально после 7го урока
    override func viewWillAppear(_ animated: Bool) {
        //filteredGroups = myGroups
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupResponse?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //получаем ячейку из пула
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? MyGroupsCell else {
            preconditionFailure("Error")
        }
        //если данные реалм не пустые, то мы их отображаем в таблице
        if let groups = groupResponse {
            cell.groupName.text = groups[indexPath.row].name
            cell.groupImageView.loadImage(with: groups[indexPath.row].image)
        }
        return cell
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let group = filteredGroups[indexPath.row]
            
            //удаляем группу
            
            filteredGroups.removeAll() {$0.name == group.name}
            
            self.searchBar(searchBar, textDidChange: searchBar.text ?? "")
        }  
    }
    
    // мигание ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension MyGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        пока не работает из-за замены массива из которого отображаются данные
        if searchText.isEmpty {
            filteredGroups = myGroups
        } else {
            filteredGroups = myGroups.filter{$0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}

//MARK: - AddGroupDelegate
extension MyGroupsController: AddGroupDelegate {
    func addGroup(id: Int, name: String) {
        let communities = FirebaseCommunities(groupName: "", id: id)
        let ref = self.ref.child(name.lowercased())
        ref.setValue(communities.toAnyObject())
    }
}

//MARK: - Private
private extension MyGroupsController {
    //отслеживает изменения?
    func createNotificationToken() {
//        объявляем токен
        token = groupResponse?.observe{ [weak self] result in
            guard let self = self else { return }
            switch result {
//                что происходит при инициализации
            case .initial(let groupsData):
                print("DBG token", groupsData.count)
//                тут можно установить значения в таблицу и обновить её

//                обновление(удалени, добавление, изменение)
            case .update(let groups,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: deletionsIndexPath, with: .automatic)
                    self.tableView.insertRows(at: insertionsIndexPath, with: .automatic)
                    self.tableView.reloadRows(at: modificationsIndexPath, with: .automatic)
                    self.tableView.endUpdates()
                }
//                ошибка
            case .error(let error):
                print("DBG token Error", error)
            }
        }
    }
    
//    метод загрузки инфы с сервера в реалм и обновление вью
    func loadGroup() {
        Task {
//            загружаем данные с сервера
            try await service.loadGroups()
//            ждем пока данные из реалма загрузятся в местные массивы
            await loadRealmData()
            tableView.reloadData()
        }
    }
    
    func loadRealmData() async {
        do {
            let realmDB = try await Realm()
            realmDB.objects(Groups.self)
                .forEach { group in
                    self.filteredGroups.append(group)
                    self.myGroups.append(group)
                }
        } catch let error as NSError {
            print("Realm Objects Error: \(error.localizedDescription)")
        }
    }
}
