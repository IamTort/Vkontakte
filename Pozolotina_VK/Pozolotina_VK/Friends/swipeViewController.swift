//
//  newViewController.swift
//  Pozolotina_VK
//
//  Created by angelina on 12.05.2022.
//

import UIKit

    //var imageList = [UIImage(named: "avto"), UIImage(named: "cat")]

class newViewController: UIViewController {
    var imageList = [User]()
    @IBOutlet weak var imagView: UIImageView!
    @IBOutlet weak var colorView: UIView!
    
    var animator: UIViewPropertyAnimator!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.isUserInteractionEnabled = true
        imagView.image = imageList[0].photos![0]
        
        animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: {
            self.colorView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        colorView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        colorView.addGestureRecognizer(swipeLeft)
    }
    
        var swipe = 0
    @objc func swipeGesture(sender: UISwipeGestureRecognizer?) {
        if let swipeGesture = sender {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if swipe >= 1 {
                    
                swipe -= 1
                UIView.animateKeyframes(withDuration: 0.6,
                                        delay: 0.2,
                                        options: .beginFromCurrentState) {
                    self.colorView.frame.origin.x = self.view.bounds.width
                    
                    UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1) {
                        self.colorView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    }
                
                } completion: { _ in
                   
                    self.colorView.frame.origin.x = .zero
                    //self.colorView.backgroundColor = .green
                    
                    UIView.animate(withDuration: 0.2,
                                   delay: 0,
                                   options: .curveEaseIn) {
                        self.colorView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.imagView.image = self.imageList[0].photos![self.swipe]
                        
                    }
                }
                    
                } else {
                    UIView.animate(withDuration: 0.2,
                                   delay: 0.2,
//                                   usingSpringWithDamping: 0.6,
//                                   initialSpringVelocity: 0.2,
                                   options: .curveLinear) {
                        self.colorView.frame.origin.x = 30
                        
                    } completion: { _ in
                        UIView.animate(withDuration: 0.4,
                                       delay: 0,
                                       usingSpringWithDamping: 0.5,
                                       initialSpringVelocity: 0.4,
                                       options: .curveEaseInOut) {
                        self.colorView.frame.origin.x = .zero
                        }
                    }

            }
                
                
                
            case UISwipeGestureRecognizer.Direction.left:
                if swipe < imageList[0].photos!.count - 1 {
                swipe += 1
                UIView.animateKeyframes(withDuration: 0.6,
                                        delay: 0.2,
                                        options: .beginFromCurrentState) {
                    self.colorView.frame.origin.x = -self.view.bounds.width
                    
                    UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1) {
                        self.colorView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    }
                } completion: { _ in
                   
                    self.colorView.frame.origin.x = .zero
                    //self.colorView.backgroundColor = .green
                    
                    UIView.animate(withDuration: 0.2,
                                   delay: 0,
                                   options: .curveEaseIn) {
                        self.colorView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.imagView.image = self.imageList[0].photos![self.swipe]
                    }
                }
                    
                } else {
                    UIView.animate(withDuration: 0.2,
                                   delay: 0.2,
//                                   usingSpringWithDamping: 0.6,
//                                   initialSpringVelocity: 0.2,
                                   options: .curveLinear) {
                        self.colorView.frame.origin.x = -30
                        
                    } completion: { _ in
                        UIView.animate(withDuration: 0.4,
                                       delay: 0,
                                       usingSpringWithDamping: 0.5,
                                       initialSpringVelocity: 0.4,
                                       options: .curveEaseInOut) {
                        self.colorView.frame.origin.x = .zero
                        }
                    }
                }
            default:
                break
            }
        }
    }
   
    
    
    
    
    
    
    
    
    
    

}
