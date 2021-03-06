//
//  SearchGroupService.swift
//  Pozolotina_VK
//
//  Created by angelina on 05.06.2022.
//

import Foundation
import RealmSwift

/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Все группы"
final class SearchGroupService {
    
    typealias GroupResult = Result<[AvailableGroups], Constants.Service.ServiceError>
    
    private lazy var session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
    func loadSearchGroups(searchText: String?, completion: @escaping (GroupResult) -> ()) {
        
        guard let token = SessionSinglton.instance.token else { return }
        //текст введенный в searchBar контроллера
        guard let text = searchText else {return}
        
        let params = ["q": text,
                      "v": "5.131",
                      "count": "40",
                      "fields": "first_name, photo_50"]
        
        let url: URL = .configureURL(token: token, typeMethod: "/method/groups.search", params: params)
        
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.requestError(error)))
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ResponseAvailableGroup.self, from: data)
                completion(.success(result.response.items))
            } catch {
                completion(.failure(.parseError))
            }
        }
        
        
//        let request = URLRequest(url: url)
//        print(request)
//        do {
//            let (data, _) = try await session.data(for: request)
//            //print(String(data: data, encoding: .utf8))
//            let decoder = JSONDecoder()
//            let result = try decoder.decode(ResponseAvailableGroup.self, from: data)
//            await saveAvailableGroup(groups: result.response.items)
//        }
    }
}



extension SearchGroupService {
    //сохранение данных в realm
    func saveAvailableGroup(groups: [AvailableGroups]) async {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        if let realm = try? await Realm(configuration: config) {
            print("REALM file =", realm.configuration.fileURL ?? "")
            do {
                try realm.write {
                    realm.add(groups, update: .modified)
                }
            } catch let error {
                print("Error Realm: \(error.localizedDescription)")
            }
        }
    }
}
