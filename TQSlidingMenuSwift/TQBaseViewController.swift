//
//  BaseViewController.swift
//  TQSlidingMenuSwift
//
//  Created by Nishant Paul on 24/02/17.
//  Copyright © 2017 TechQuench. All rights reserved.
//

import UIKit

open class TQBaseViewController: UIViewController, MenuControllerDelegate
{
    var presentationVC: TQPresentationController?
    var menuControllerId: String?

    func menuClicked()
    {
        let rearViewController = storyboard!.instantiateViewController(withIdentifier: self.menuControllerId!) as! TQMenuController
        
        // Set menu controller delegate
        rearViewController.menuDelegate = self
        
        self.presentationVC = TQPresentationController(presentedViewController: rearViewController, presenting: self)
        rearViewController.transitioningDelegate = self.presentationVC
        
        // Set the delegate
//        self.presentationVC?.presentationDelegate = self
        
        self.present(rearViewController, animated: true, completion: nil)
    }
    
    open func setNavigtionMenu(withScreenTitle screenTitle: String, withMenuControllerId id: String)
    {
        let item1 = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuClicked))
        self.navigationItem.setLeftBarButton(item1, animated: true)
        self.menuControllerId = id
        self.navigationItem.title = screenTitle
    }
    
    func presentViewController(withId id: String) {
        var controllers = self.navigationController?.viewControllers
        let destinationVC = storyboard!.instantiateViewController(withIdentifier: id)
        //        controllers?.
        controllers?.append(destinationVC)
        self.navigationController?.setViewControllers(controllers!, animated: false)
    }
}
