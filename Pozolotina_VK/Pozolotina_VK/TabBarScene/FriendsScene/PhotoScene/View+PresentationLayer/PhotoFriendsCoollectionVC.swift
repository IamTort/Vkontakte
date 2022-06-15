//
//  PhotoController.swift
//  Pozolotina_VK
//
//  Created by angelina on 16.04.2022.
//

import UIKit


private let reuseIdentifier = "Cell"
class PhotoFriendsCoollectionVC: UICollectionViewController {

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPhoto()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    let collectionPhotos = FriendViewController()
    
    private let service = PhotoService()
    
    var friendId: String = ""
    var storedModels: [Sizes] = []
    var storedImages: [String] = []
    
    // MARK: - Table view data source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        storedImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
//        let photo = friends[indexPath.row].image
        cell.photoImageView.loadImage(with: storedImages[indexPath.item])
    
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "slideIt",
          let destination = segue.destination as? newViewController,
            let cell = sender as? UICollectionViewCell,
          let indexPath = collectionView.indexPath(for: cell){
                 
           //destination.imageList.append(self.friends[indexPath.row])
                
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

//MARK: - Private
private extension PhotoFriendsCoollectionVC {
    func fetchPhoto(){
        service.loadPhotos(for: friendId) { [weak self] photos in
            self?.storedModels = photos
            if let imagesLinks = self?.sortImage(type: "z", array: photos) {
                self?.storedImages = imagesLinks
            }
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func sortImage(type: String, array: [Sizes]) -> [String] {
        var links: [String] = []
        
        for model in array {
            for size in model.sizes {
                if size.type == type {
                    links.append(size.url)
                }
            }
        }
        return links
    }
}
