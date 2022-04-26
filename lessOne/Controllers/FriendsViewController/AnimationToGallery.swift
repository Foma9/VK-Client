//
//  AnimationFriendsView.swift
//  lessOne
//
//  Created by Евгений Ефименко on 19.03.2022.
//

import UIKit

class AnimationToGallery: NSObject, UIViewControllerAnimatedTransitioning {


    let durationInterval: Double = 1

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {

        return durationInterval
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let sourceVC = transitionContext.viewController(forKey: .from),
              let destinationVC = transitionContext.viewController(forKey: .to) else {return}

        transitionContext.containerView.addSubview(destinationVC.view)
        destinationVC.view.frame = sourceVC.view.frame

        sourceVC.view.setAnchorPoint(CGPoint(x: 0, y: 0))
        destinationVC.view.setAnchorPoint(CGPoint(x: 1, y: 0))
        destinationVC.view.transform = CGAffineTransform(rotationAngle: -.pi / 2)


        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.8) {

                let translation = CGAffineTransform(rotationAngle: .pi + .pi)
                destinationVC.view.transform = translation
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3,
                               relativeDuration: 0.3) {

                let translation = CGAffineTransform(rotationAngle: .pi + .pi)
                destinationVC.view.transform = translation
            }

            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.5) {
                destinationVC.view.transform = .identity
            }

        }) { finished in

            if finished && !transitionContext.transitionWasCancelled {
                sourceVC.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

extension UIView {

    func setAnchorPoint(_ point: CGPoint) {

        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point

    }
}
