//
//  NotMyGroupsController.swift
//  Pozolotina_VK
//
//  Created by angelina on 15.04.2022.
//

import UIKit

class NotMyGroupsController: UITableViewController {

    
    var availableGroup = [
        Group(image: UIImage(named: "ponchik")!, name: "Сочные плюшки"),
        Group(image: UIImage(named: "remont")!, name: "Ремонт и дом"),
        Group(image: UIImage(named: "avto")!, name: "Автотюнинг"),
        Group(image: UIImage(named: "mushrooms")!, name: "Собиратели грибов"),
        Group(image: UIImage(named: "cat")!, name: "Смешные коты"),
        Group(image: UIImage(named: "moms")!, name: "Мамочки Москвы")
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotMyGroups()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return availableGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoMyGroup", for: indexPath) as! NoMyGroupCell
        
        cell.groupName.text = availableGroup[indexPath.row].name
        cell.availableGroupImageView.image = availableGroup[indexPath.row].image

        return cell
    }
   
    
    func loadNotMyGroups(){
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        //поиск всех групп
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(describing: SessionSinglton.instance.userId!)),
            URLQueryItem(name: "access_token", value: String(describing: SessionSinglton.instance.token!)),
            URLQueryItem(name: "v", value: "5.131"),
            //пишем какие группы искать
            URLQueryItem(name: "q", value: "nature")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
              
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(result)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
