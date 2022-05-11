//
//  loadingPageViewController.swift
//  Pozolotina_VK
//
//  Created by angelina on 01.05.2022.
//

import UIKit

class loadingPageViewController: UIViewController {

    @IBOutlet var viewAnim: UIView!
    @IBOutlet var imageAnim: UIImageView!
    @IBOutlet var imageAnim1: UIImageView!
    @IBOutlet var imageAnim2: UIImageView!
    
    
    @IBOutlet var Ycons: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageAnim.layer.cornerRadius = 20
        imageAnim1.layer.cornerRadius = 20
        imageAnim2.layer.cornerRadius = 20
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0.5) {
//            self.viewAnim.layer.position.x += 150
//            self.viewAnim.backgroundColor = .red
//        }
        
        
//        UIView.animate(withDuration: 5) {
//            self.viewAnim.layer.position.x += 150
//            self.viewAnim.backgroundColor = .red
//        } completion: { _ in
//            UIView.animate(withDuration: 1) {
//                self.viewAnim.layer.position.y -= 150
//            }
//        }
        
        
//        UIView.animate(withDuration: 3,
//                       delay: 1,
//                       options: [.curveEaseInOut, .autoreverse, .repeat]) {
//            self.viewAnim.layer.position.x += 150
//            // мигание
//            self.viewAnim.alpha = 0
//        }
        
        UIImageView.animate(withDuration: 1.2,
                            delay: 0.5,
                            options: [.autoreverse, .repeat]) {
            self.imageAnim.alpha = 0
        }
        
        UIImageView.animate(withDuration: 1.2,
                            delay: 1.2,
                            options: [.autoreverse, .repeat]) {
            self.imageAnim1.alpha = 0
        }
        
        UIImageView.animate(withDuration: 1.2,
                            delay: 1.9,
                            options: [.autoreverse, .repeat]) {
            self.imageAnim2.alpha = 0
        }
        
    }
    
    @IBAction func tapAnim(_ sender: Any) {
//        Ycons.isActive.toggle()
//
//        let colorStandart = Ycons.isActive
//
//        UIView.animate(withDuration: 3) {
//            self.view.layoutIfNeeded()
//        }
//
//        UIView.transition(with: viewAnim,
//                          duration: 1,
//                          options: .transitionFlipFromRight) {
//            self.viewAnim.backgroundColor = colorStandart ? .red : .cyan
//        }
//
        
        
//        let moveAnim = CASpringAnimation(keyPath: "position.y")
//        moveAnim.fromValue = viewAnim.layer.position.y
//        moveAnim.toValue = viewAnim.layer.position.y + 200
//        moveAnim.duration = 0.5
//
//
//        moveAnim.damping = 0.3
//        moveAnim.initialVelocity = 2
//        moveAnim.mass = 2
//        moveAnim.stiffness = 4
//
//        viewAnim.layer.add(moveAnim, forKey: nil)
//
//        viewAnim.layer.position.y = viewAnim.layer.position.y + 200
        
        
        
//        // пружинная анимация
//        UIView.animate(withDuration: 0.3,
//                       delay: 0.2,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 10,
//                       options: .curveEaseInOut) {
//            self.viewAnim.layer.position.y += 150
//        }
        
        
        
//        UIView.animate(withDuration: 0.3,
//                               delay: 0.2,
//                               usingSpringWithDamping: 0.5,
//                               initialSpringVelocity: 10,
//                               options: .curveEaseInOut) {
//            self.viewAnim.transform = CGAffineTransform(translationX: 0, y: 150)
//            }
//
//        viewAnim.transform = .identity
//
//
   }
    
}
