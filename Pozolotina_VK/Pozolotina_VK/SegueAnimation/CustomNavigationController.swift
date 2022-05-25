//
//  CustomNavigationController.swift
//  Pozolotina_VK
//
//  Created by angelina on 25.05.2022.
//

import UIKit


class CustomInteractiveTransiti: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}


class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    let interactiveTransition = CustomInteractiveTransiti()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        
        let edgePanGR = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        view.addGestureRecognizer(edgePanGR)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushAnimator()
        case .pop:
            return PopAnimator()
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    @objc private func handlePanGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            // пользователь начал тянуть - стартуем pop-анимацию и выставляем флаг hasStarted
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
            
        case .changed:
            //пользователь продолжает тянуть - расчитываем размер экрана
            guard let widht = recognizer.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            //рассчитывем длину перемещения пальца
            let translation = recognizer.translation(in: recognizer.view)
            //рассчитываем процент перемещения пальца относительно размера экрана
            let relativeTranslation = translation.x / widht
            let progress = max(0, min(1, relativeTranslation))
            //выставляем соответствующий прогресс интерактивной анимации
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinish = progress > 0.45
            
        case .ended:
            //завершаем анимацию в зависимости от пройденного прогресса
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
        @unknown default:
            break
        }
    }
}
