//
//  MenuController.swift
//  TQSlidingMenuSwift
//
//  Created by Nishant Paul on 24/02/17.
//  Copyright © 2017 TechQuench. All rights reserved.
//

import UIKit

protocol MenuControllerDelegate: NSObjectProtocol
{
    func presentViewController(withId id: String)
}

open class TQMenuController: UITableViewController
{
    weak var menuDelegate: MenuControllerDelegate?
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.updatePreferredContentSize(withTraitCollection: self.traitCollection)
    }

    func updatePreferredContentSize(withTraitCollection traitCollection: UITraitCollection)
    {
        self.preferredContentSize = CGSize(width: traitCollection.verticalSizeClass == .regular ? 220 : 300, height: view.bounds.size.height)
    }
    
    override open func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        self.updatePreferredContentSize(withTraitCollection: newCollection)
    }
    
    open func performCustomSegue(withIdentifier id: String)
    {
        menuDelegate?.presentViewController(withId: id)
    }
}
