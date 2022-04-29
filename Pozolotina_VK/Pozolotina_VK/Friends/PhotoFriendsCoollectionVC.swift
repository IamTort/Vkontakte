//
//  PhotoController.swift
//  Pozolotina_VK
//
//  Created by angelina on 16.04.2022.
//

import UIKit

//Сделал на примере аватарок, то есть они будут выходить на большой экран, по аналогии и другие фото из Модели..
class PhotoFriendsCoollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    let collectionPhotos = FriendsViewController()
    
    var friends = [User]()
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(friends[0].name)
        return friends.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let photo = friends[indexPath.row].image
        cell.photoImageView.image = photo
    
        // Configure the cell
    
        return cell
    }
    
    
    
}





/*
    private let reuseIdentifier = "Cell"
class PhotoController: UICollectionViewController {
    var friends = [User]()
    var friendsName: String?
    var friendsImageView : UIImage?
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
       self.collectionView!.register(UICollectionViewCell.self,  forCellWithReuseIdentifier: "checkPhoto")

        // Do any additional setup after loading the view.
    }
    


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return friends.count
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            preconditionFailure("Error")
        }
        
        //print(friends)
        // Configure the cell
        cell.photoImageView.image = friends[indexPath.row].image
        

        return cell
    }

}
*/


