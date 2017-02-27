//
//  BaseViewController.swift
//  TQSlidingMenuSwift
//
//  Created by Nishant Paul on 24/02/17.
//  Copyright © 2017 TechQuench. All rights reserved.
//

import UIKit

class TQBaseViewController: UIViewController
{
    
    var presentationVC: TQPresentationController?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(pushViewController(_:)), name: Notification.Name(rawValue: "pushViewController"), object: nil)
    }

    func menuClicked()
    {
        let rearViewController = storyboard!.instantiateViewController(withIdentifier: "menuVC")
        
        self.presentationVC = TQPresentationController(presentedViewController: rearViewController, presenting: self)
        rearViewController.transitioningDelegate = self.presentationVC
        
        // Set the delegate
//        self.presentationVC?.presentationDelegate = self
        
        self.present(rearViewController, animated: true, completion: nil)
    }
    
    func addMenu(withTitle title: String)
    {
        let item1 = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuClicked))
        self.navigationItem.setLeftBarButton(item1, animated: true)
        print(title)
        self.navigationItem.title = title
    }
    
    func pushViewController(_ notification: Notification)
    {
        let idString = notification.userInfo?["id"] as? String
        pushView(idString!)
    }
    
    func pushView(_ id:String)
    {
        let destinationVC = storyboard!.instantiateViewController(withIdentifier: id)
        var controllers = self.navigationController?.viewControllers
        controllers?[0] = destinationVC
        self.navigationController?.setViewControllers(controllers!, animated: false)
    }
}
