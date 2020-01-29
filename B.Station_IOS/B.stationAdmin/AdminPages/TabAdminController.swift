//
//  TabAdminController.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/24/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class TabAdminController: UITabBarController {

     var index :Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = index ?? 0
    }
    
}
