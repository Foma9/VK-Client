//
//  AnimationToGalleryView.swift
//  lessOne
//
//  Created by Евгений Ефименко on 22.04.2022.
//

import UIKit

class AnimationToFriends: NSObject, UIViewControllerAnimatedTransitioning {

    let durationInterval: Double = 1

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {

        return durationInterval
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let sourceVC = transitionContext.viewController(forKey: .from),
              let destinationVC = transitionContext.viewController(forKey: .to) else {return}

        transitionContext.containerView.addSubview(destinationVC.view)
        transitionContext.containerView.sendSubviewToBack(destinationVC.view)

        destinationVC.view.frame = sourceVC.view.frame

        sourceVC.view.setAnchorPoint(CGPoint(x: 1, y: 0))
        destinationVC.view.setAnchorPoint(CGPoint(x: 0, y: 0))
        destinationVC.view.transform = CGAffineTransform(rotationAngle: .pi / 2)


        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.8) {

                let translation = CGAffineTransform(rotationAngle: .pi)
                sourceVC.view.transform = translation
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3,
                               relativeDuration: 0.3) {

                destinationVC.view.transform = CGAffineTransform(rotationAngle: .pi / 2)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.5) {
                destinationVC.view.transform = .identity
            }

        }) { finished in

            if finished && !transitionContext.transitionWasCancelled {
                sourceVC.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destinationVC.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

