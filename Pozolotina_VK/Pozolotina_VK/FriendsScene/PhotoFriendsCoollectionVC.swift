//
//  PhotoController.swift
//  Pozolotina_VK
//
//  Created by angelina on 16.04.2022.
//

import UIKit


private let reuseIdentifier = "Cell"
class PhotoFriendsCoollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPhotos()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    let collectionPhotos = FriendsViewController()
    
    var friends = [User]()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return friends.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let photo = friends[indexPath.row].image
        cell.photoImageView.image = photo
    
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "slideIt",
          let destination = segue.destination as? newViewController,
            let cell = sender as? UICollectionViewCell,
          let indexPath = collectionView.indexPath(for: cell){
                 
           destination.imageList.append(self.friends[indexPath.row])
                
       }
    }
    
    
    func loadPhotos(){
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        //получаем все мои фото по данному методу
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            //если изменить owner_id то покажет фото выбранного друга
            URLQueryItem(name: "owner_id", value: String(describing: SessionSinglton.instance.userId!)),
            URLQueryItem(name: "access_token", value: String(describing: SessionSinglton.instance.token!)),
            URLQueryItem(name: "v", value: "5.131"),
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


//extension PhotoFriendsCoollectionVC: UIViewControllerTransitioningDelegate  {
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return PushAnimator()
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return PopAnimator()
//    }
//
//}


