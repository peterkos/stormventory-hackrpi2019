//
//  MainTabBarViewController.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/3/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController, UserDataHandler {

    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        for childVC in children {
            // Navigate through 0th navigation controller
            // (TabBar -> NavigationVC_0 -> VC0)
            if var userDataVC = childVC.children.first as? UserDataHandler {
                userDataVC.user = user
            }
        }
    }

}
