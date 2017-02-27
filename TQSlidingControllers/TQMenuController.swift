//
//  MenuController.swift
//  TQSlidingMenuSwift
//
//  Created by Nishant Paul on 24/02/17.
//  Copyright © 2017 TechQuench. All rights reserved.
//

import UIKit

class TQMenuController: UITableViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.updatePreferredContentSize(withTraitCollection: self.traitCollection)
    }

    func updatePreferredContentSize(withTraitCollection traitCollection: UITraitCollection)
    {
        self.preferredContentSize = CGSize(width: traitCollection.verticalSizeClass == .regular ? 220 : 300, height: view.bounds.size.height)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        self.updatePreferredContentSize(withTraitCollection: newCollection)
    }
    
    func performCustomSegue(withIdentifier: String)
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: nil, userInfo: ["id": withIdentifier])
    }
}
