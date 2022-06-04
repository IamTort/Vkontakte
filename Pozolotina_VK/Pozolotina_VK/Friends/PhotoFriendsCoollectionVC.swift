//
//  PhotoController.swift
//  Pozolotina_VK
//
//  Created by angelina on 16.04.2022.
//

import UIKit

//Сделал на примере аватарок, то есть они будут выходить на большой экран, по аналогии и другие фото из Модели..

private let reuseIdentifier = "Cell"
class PhotoFriendsCoollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    let collectionPhotos = FriendsViewController()
    
    var friends = [User]()
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //print(friends[0].name)
        return friends.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let photo = friends[indexPath.row].image
        cell.photoImageView.image = photo
    
        // Configure the cell
    
        return cell
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "slideIt",
          let destination = segue.destination as? newViewController,
            let cell = sender as? UICollectionViewCell,
          let indexPath = collectionView.indexPath(for: cell){
                 //let realname = searchList[keySelected]![indexPath.row]
           destination.imageList.append(self.friends[indexPath.row])
                
       }
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


