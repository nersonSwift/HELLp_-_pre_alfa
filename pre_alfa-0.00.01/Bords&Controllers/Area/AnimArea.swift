//
//  animArea.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 24.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class AnimArea: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    var dir = Dir.Down
    
    init(dir: Dir) {
        self.dir = dir
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        
        var offScreenFirst = CGAffineTransform(translationX: 0, y: -container.frame.height)
        var offScreenSecond = CGAffineTransform(translationX: 0, y: container.frame.height)
        
        switch dir {
        case .Up:
            offScreenFirst = CGAffineTransform(translationX: 0, y: -container.frame.height)
            offScreenSecond = CGAffineTransform(translationX: 0, y: container.frame.height)
        case .Right:
            offScreenFirst = CGAffineTransform(translationX: container.frame.width, y: 0)
            offScreenSecond = CGAffineTransform(translationX: -container.frame.width, y: 0)
        case .Down:
            offScreenFirst = CGAffineTransform(translationX: 0, y: container.frame.height)
            offScreenSecond = CGAffineTransform(translationX: 0, y: -container.frame.height)
        case .Left:
            offScreenFirst = CGAffineTransform(translationX: -container.frame.width, y: 0)
            offScreenSecond = CGAffineTransform(translationX: container.frame.width, y: 0)
        }
        
        toView.transform = offScreenFirst
        
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        
        let duration = self.transitionDuration(using: transitionContext)
        
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.81, options: [], animations: { () -> Void in
            fromView.transform = offScreenSecond
            toView.transform = CGAffineTransform.identity
        }) { (finished) -> Void in
            
            transitionContext.completeTransition(true)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.9
    }
    
    
}
