//
//  ZoomTransition.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/24.
//

import UIKit

protocol ZoomingViewController {
    func zoomingImageView(for transition: ZoomTransition) -> UIImageView?
    func zoomingBackgroundView(for transition: ZoomTransition) -> UIView?
}

enum TransitionState {
    case initial
    case final
}

class ZoomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var transitionDuration: TimeInterval = 0.5
    var operation: UINavigationController.Operation = .none
    private let zoomScale: CGFloat = 15
    private let backgroundScale: CGFloat = 0.8
    
    typealias ZoomingViews = (otherView: UIView, imageView: UIView)
    
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews) {
        switch state {
        case .initial:
            backgroundViewController.view.transform = .identity
            backgroundViewController.view.alpha = 1
            viewsInForeground.otherView.alpha = 0
            
            snapshotViews.imageView.frame = containerView.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotViews.imageView.frame = containerView.convert(viewsInForeground.imageView.frame, from: viewsInForeground.imageView.superview)
            snapshotViews.otherView.backgroundColor = .red
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        guard let backgroundImageView = (backgroundViewController as? ZoomingViewController)?.zoomingImageView(for: self),
              let foregroundImageView = (foregroundViewController as? ZoomingViewController)?.zoomingImageView(for: self),
              let backgroundView = (backgroundViewController as? ZoomingViewController)?.zoomingBackgroundView(for: self),
              let foregroundView = (foregroundViewController as? ZoomingViewController)?.zoomingBackgroundView(for: self)
        else { return }
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        let overlay = UIView(frame: imageViewSnapshot.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        imageViewSnapshot.addSubview(overlay)
        
        imageViewSnapshot.contentMode = .scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true
        imageViewSnapshot.layer.cornerRadius = 10
        
        let backgroundViewSnapshot = UIView(frame: containerView.bounds)
        backgroundViewSnapshot.backgroundColor = .black
        
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        
        let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.backgroundColor = UIColor.clear
        containerView.backgroundColor = UIColor.black
        
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(foregroundViewController.view)
        containerView.addSubview(imageViewSnapshot)
        
        var preTransitionState = TransitionState.initial
        var postTransitionState = TransitionState.final
        
        if operation == .pop {
            foregroundViewController.view.alpha = 0
            
            preTransitionState = .final
            postTransitionState = .initial
        }
        
        configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundView, backgroundImageView), viewsInForeground: (foregroundView, foregroundImageView), snapshotViews: (backgroundViewSnapshot, imageViewSnapshot))
        
        foregroundViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            
            self.configureViews(for: postTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundView, backgroundImageView), viewsInForeground: (foregroundView, foregroundImageView), snapshotViews: (backgroundViewSnapshot, imageViewSnapshot))
            
        }) { (finished) in
            
            backgroundViewController.view.transform = CGAffineTransform.identity
            imageViewSnapshot.removeFromSuperview()
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            foregroundViewController.view.alpha = 1
            foregroundViewController.view.backgroundColor = foregroundViewBackgroundColor
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}


extension ZoomTransition : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard fromVC is ZoomingViewController && toVC is ZoomingViewController else {
            return nil
        }
        
        self.operation = operation
        return self
    }
}
