//
//  GoogleVC.swift
//  TQSlidingMenuSwift
//
//  Created by Nishant Paul on 18/02/17.
//  Copyright © 2017 TechQuench. All rights reserved.
//

import UIKit

class AppleVC: TQBaseViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Add Menu to your view controller
        setNavigtionMenu(withScreenTitle: "Apple", withMenuControllerId: "menuVC")
    }
}
