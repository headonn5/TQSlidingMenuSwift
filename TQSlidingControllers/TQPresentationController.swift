//
//  PresentationController.swift
//  TQSlidingMenuSwift
//
//  Created by Nishant Paul on 17/02/17.
//  Copyright © 2017 TechQuench. All rights reserved.
//

import UIKit

protocol TQPresentationControllerDelegate
{
    func updateViewController()
}

class TQPresentationController: UIPresentationController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
{
    var presentationWrappingView: UIView?
    var translucentView: UIView?
    // delegate
    var presentationDelegate: TQPresentationControllerDelegate?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?)
    {
        self.presentationWrappingView = UIView(frame: .zero)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom;
    }
    
    override var presentedView: UIView?
    {
        return self.presentationWrappingView
    }
    
    override func presentationTransitionWillBegin()
    {
        
        let presentedViewControllerView: UIView = super.presentedView!
        
        let presentationWrapperView: UIView = UIView(frame: self.frameOfPresentedViewInContainerView)
        presentationWrapperView.layer.shadowOpacity = 0.44
        presentationWrapperView.layer.shadowRadius = 10.0
        presentationWrapperView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.presentationWrappingView = presentationWrapperView
        
        let presentationRoundedCornerView: UIView = UIView(frame: UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, -15, 0, 0)))
        presentationRoundedCornerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentationRoundedCornerView.layer.cornerRadius = 15
        presentationRoundedCornerView.layer.masksToBounds = true
        
        let presentedViewControllerWrapperView: UIView = UIView(frame: UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 15, 0, 0)))
        presentedViewControllerWrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        presentedViewControllerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds
        presentedViewControllerWrapperView.addSubview(presentedViewControllerView)
        
        presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView)
        
        presentationWrapperView.addSubview(presentationRoundedCornerView)
        
        let translucentView = UIView(frame: (containerView?.bounds)!)
        translucentView.backgroundColor = .black
        translucentView.isOpaque = false
        translucentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        translucentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(translucentViewTapped(_:))))
        self.translucentView = translucentView
        self.containerView?.addSubview(translucentView)
        
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        self.translucentView?.alpha = 0.0
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.translucentView?.alpha = 0.1
        }, completion: nil)
    }
    
    func translucentViewTapped(_ sender: UITapGestureRecognizer)
    {
        self.presentingViewController.dismiss(animated: true, completion: nil)
        presentationDelegate?.updateViewController()
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool)
    {
        if completed == false {
            self.presentationWrappingView = nil
        }
    }
    
    override func dismissalTransitionWillBegin()
    {
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            // dismiss transition will begin
        }, completion: nil)
        // Make the translucent view as transparent when user dismisses the menu
        self.translucentView?.alpha = 0.0
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool)
    {
        if completed == true {
            self.presentationWrappingView = nil
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return (transitionContext?.isAnimated)! ? 0.4 : 0.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        self.translateMenuOverViewController(using: transitionContext)
//        self.translateMenuAlongWithViewController(using: transitionContext)
    }
    
    func translateMenuAlongWithViewController(using transitionContext: UIViewControllerContextTransitioning)
    {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        let isPresenting = fromVC == self.presentingViewController
        
        // Set up some variables for the animation.
//        var toViewStartFrame:CGRect = transitionContext.initialFrame(for: toVC!)
        let toViewFinalFrame:CGRect = transitionContext.finalFrame(for: toVC!)
        let fromViewStartFrame: CGRect = transitionContext.initialFrame(for: fromVC!)
        var fromViewFinalFrame:CGRect = transitionContext.finalFrame(for: fromVC!)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        if isPresenting {
            containerView.addSubview(toView!)
        }
        let offset = CGVector(dx: -1.0, dy: 0.0)
        // Set up the animation parameters.
        if isPresenting {
            fromView?.frame = fromViewStartFrame
            toView?.frame = toViewFinalFrame.offsetBy(dx: toViewFinalFrame.size.width * offset.dx * -1, dy: toViewFinalFrame.size.height * offset.dy * -1)
        }
        else {
            fromViewFinalFrame.origin.x = 0
            fromViewFinalFrame.origin.y = 0
            fromViewFinalFrame.size.height = (fromView?.frame.size.height)!
        }
        
        UIView.animate(withDuration: transitionDuration, animations: { 
            if isPresenting {
                fromView?.frame = fromViewStartFrame.offsetBy(dx: fromViewStartFrame.size.width * offset.dx, dy: fromViewStartFrame.size.height * offset.dy)
                toView?.frame = toViewFinalFrame
            }
            else {
                fromView?.frame = fromViewFinalFrame
            }
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
    func translateMenuOverViewController(using transitionContext: UIViewControllerContextTransitioning)
    {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        let isPresenting = fromVC == self.presentingViewController
        
        // Set up some variables for the animation.
        var toViewStartFrame:CGRect = transitionContext.initialFrame(for: toVC!)
        let toViewFinalFrame:CGRect = transitionContext.finalFrame(for: toVC!)
        var fromViewFinalFrame:CGRect = transitionContext.finalFrame(for: fromVC!)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        if isPresenting {
            containerView.addSubview(toView!)
        }
        
        // Set up the animation parameters.
        if isPresenting {
            toViewStartFrame.origin.x = 0
            toViewStartFrame.origin.y = 0
            toViewStartFrame.size.height = (toView?.frame.size.height)!
            toView?.frame = toViewStartFrame
        }
        else {
            fromViewFinalFrame.origin.x = -(fromView?.frame.size.width)!
            fromViewFinalFrame.origin.y = 0
            fromViewFinalFrame.size.height = (fromView?.frame.size.height)!
        }
        
        // Animate using the animator's own duration value.
        UIView.animate(withDuration: transitionDuration, animations: {
            if isPresenting {
                toView?.frame = toViewFinalFrame
            }
            else {
                fromView?.frame = fromViewFinalFrame
            }
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer)
    {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if (container as! UIViewController) == self.presentedViewController {
            self.containerView?.setNeedsLayout()
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize
    {
        if (container as! UIViewController) == self.presentedViewController {
            return (container as! UIViewController).preferredContentSize
        }
        return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect
    {
        let containerViewBounds = self.containerView?.bounds
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: (containerViewBounds?.size)!)
        
        var presentedViewControllerFrame = containerViewBounds
        presentedViewControllerFrame?.size.height = presentedViewContentSize.height
        presentedViewControllerFrame?.size.width = presentedViewContentSize.width
        presentedViewControllerFrame?.origin.x = 0
        presentedViewControllerFrame?.origin.y = 0
        
        return presentedViewControllerFrame!
    }
    
    override func containerViewWillLayoutSubviews()
    {
        super.containerViewWillLayoutSubviews()
        self.presentationWrappingView?.frame = self.frameOfPresentedViewInContainerView
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self
    }
}
