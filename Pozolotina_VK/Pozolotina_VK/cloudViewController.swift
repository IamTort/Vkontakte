//
//  cloudViewController.swift
//  Pozolotina_VK
//
//  Created by angelina on 19.05.2022.
//

import UIKit

class cloudViewController: UIViewController {

    @IBOutlet weak var cloudView: UIView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var whitePath: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let layer = CAShapeLayer()
        layer.path = bezierPath.cgPath
        
        layer.lineWidth = 3
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.gray.cgColor
        
        
        layer.strokeEnd = 1
        layer.strokeStart = 0
        
        cloudView.layer.addSublayer(layer)
        
        
        let layer1 = CAShapeLayer()
        layer1.path = bezierPath.cgPath

        layer1.lineWidth = 4
        layer1.strokeColor = UIColor.gray.cgColor
        layer1.fillColor = UIColor.white.cgColor


        layer1.strokeEnd = 1
        layer1.strokeStart = 0

        backView.layer.addSublayer(layer1)
        
        
        let layer2 = CAShapeLayer()
        layer2.path = bezierPath.cgPath
        
        layer2.lineWidth = 0
        layer2.strokeColor = UIColor.blue.cgColor
        layer2.fillColor = UIColor.white.cgColor
        
        
        layer2.strokeEnd = 1
        layer2.strokeStart = 0
        
        whitePath.layer.addSublayer(layer2)
        
        
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        
        //strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        strokeStartAnimation.fromValue = -0.25
        strokeStartAnimation.toValue = 1
        
        //strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation]
        animationGroup.duration = 4
        animationGroup.repeatCount = .infinity
        layer.add(animationGroup, forKey: nil)
        
        cloudView.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        cloudView.layer.bounds.origin.x = -100
        cloudView.layer.bounds.origin.y = -100
        
        
        
        
    }
    
    let bezierPath: UIBezierPath = {
        let path = UIBezierPath()
    path.move(to: CGPoint(x: 56.5, y: 61.5))
    path.addCurve(to: CGPoint(x: 97.5, y: 61.5), controlPoint1: CGPoint(x: 55.5, y: 61.5), controlPoint2: CGPoint(x: 97.5, y: 61.5))
    path.addCurve(to: CGPoint(x: 105.5, y: 53.5), controlPoint1: CGPoint(x: 97.5, y: 61.5), controlPoint2: CGPoint(x: 110.5, y: 60.5))
    path.addCurve(to: CGPoint(x: 94.5, y: 49.5), controlPoint1: CGPoint(x: 100.5, y: 46.5), controlPoint2: CGPoint(x: 94.5, y: 49.5))
    path.addCurve(to: CGPoint(x: 94.5, y: 42.5), controlPoint1: CGPoint(x: 94.5, y: 49.5), controlPoint2: CGPoint(x: 101.5, y: 46.5))
    path.addCurve(to: CGPoint(x: 86.5, y: 42.5), controlPoint1: CGPoint(x: 87.5, y: 38.5), controlPoint2: CGPoint(x: 86.5, y: 42.5))
    path.addCurve(to: CGPoint(x: 76.5, y: 33.5), controlPoint1: CGPoint(x: 86.5, y: 42.5), controlPoint2: CGPoint(x: 82.5, y: 30.5))
    path.addCurve(to: CGPoint(x: 69.5, y: 42.5), controlPoint1: CGPoint(x: 70.5, y: 36.5), controlPoint2: CGPoint(x: 69.5, y: 42.5))
    path.addCurve(to: CGPoint(x: 56.5, y: 42.5), controlPoint1: CGPoint(x: 69.5, y: 42.5), controlPoint2: CGPoint(x: 59.5, y: 35.5))
    path.addCurve(to: CGPoint(x: 56.5, y: 53.5), controlPoint1: CGPoint(x: 53.5, y: 49.5), controlPoint2: CGPoint(x: 56.5, y: 53.5))
    path.addCurve(to: CGPoint(x: 47.5, y: 57.5), controlPoint1: CGPoint(x: 56.5, y: 53.5), controlPoint2: CGPoint(x: 47.5, y: 53.5))
    path.addCurve(to: CGPoint(x: 56.5, y: 61.5), controlPoint1: CGPoint(x: 47.5, y: 61.5), controlPoint2: CGPoint(x: 57.5, y: 61.5))
    path.close()
    UIColor.gray.setFill()
    path.fill()
    UIColor.black.setStroke()
    path.lineWidth = 1
    path.stroke()

        path.close()
        return path
    }()
    

}
