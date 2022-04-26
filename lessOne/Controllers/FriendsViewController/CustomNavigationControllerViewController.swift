//
//  CustomNavigationControllerViewController.swift
//  lessOne
//
//  Created by Евгений Ефименко on 22.04.2022.
//

import UIKit

class CustomNavigationControllerViewController: UINavigationController, UINavigationControllerDelegate {

    let interactiveTransition = CustomInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            if operation == .push {
                self.interactiveTransition.viewController = toVC
                return AnimationToGallery()
            } else if operation == .pop {
                if navigationController.viewControllers.first != toVC {
                    self.interactiveTransition.viewController = toVC
                }
                return AnimationToFriends()
            }
            return nil
    }

    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

