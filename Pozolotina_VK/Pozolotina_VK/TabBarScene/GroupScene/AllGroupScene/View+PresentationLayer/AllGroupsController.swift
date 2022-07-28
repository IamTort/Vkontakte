//
//  NotMyGroupsController.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit
import RealmSwift


protocol AddGroupDelegate: AnyObject {
    ///Добавить группу
    /// - Parameters:
    ///  - id: Идентификатор группы
    ///  - name: Имя группы
    func addGroup(id: Int, name: String)
}

class AllGroupsController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
//    чтоб добраться для методов класса сервис, создаем экземпляр класса
    let service = GroupService()
// в этот массив добавляются группы по методу серчбар и этот массив отображается во вью
    private var filteredGroups: [Groups] = []
// ссылка на экземпляр класса
    private let realmService = RealmCacheService()
    
    ///Делегат добавления группы
    weak var delegate: AddGroupDelegate?
    
    //MARK: - LifeCycle
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
        //return allGroups.count
        return filteredGroups.count
    }
//    метод, кот инициирует добавление глобальной группы в мои группы
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = filteredGroups[indexPath.row].id
        let group = filteredGroups[indexPath.row]
        delegate?.addGroup(id: id, name: group.name)
        service.addGroup(id: id) { result in
            switch result {
            case .success(let join):
                if join.response == 1 {
                self.realmService.create(group)
                }
            case .failure(let error):
                print(error)
            }
        }
//        переходим на контроллер назад
        navigationController?.popViewController(animated: true)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoMyGroup", for: indexPath) as! AllGroupCell
        
        cell.groupName.text = filteredGroups[indexPath.row].name
        cell.availableGroupImageView.loadImage(with: filteredGroups[indexPath.row].image)

        return cell
    }
    
}

//MARK: - UISearchBarDelegate
extension AllGroupsController: UISearchBarDelegate {
//    поиск по строке ввода
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.isEmpty ? " ": searchText
        filteredGroups = []
        service.loadSearchGroups(searchText: text) { [weak self] result in
            switch result {
            case .success(let groups):
                self?.filteredGroups = groups
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
//не нужно потому, что нам не удобно сохранять в реалм все группы, что мы ищем
//MARK: - Private
//private extension AllGroupsController {
//
//    func loadGroup() {
//        Task {
//            try await service.loadSearchGroups(searchText: searchBar.text)
//            await loadRealmData()
//            tableView.reloadData()
//        }
//    }
//
//    func loadRealmData() async {
//        do {
//            let realmDB = try await Realm()
//            realmDB.objects(AvailableGroups.self)
//                .forEach { group in
//                    self.groupModel = group
//                    self.allGroups.append(group)
//                }
//        } catch let error as NSError {
//            print("Realm Objects Error: \(error.localizedDescription)")
//        }
//    }
//}
