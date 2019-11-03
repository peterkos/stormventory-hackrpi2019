//
//  LoginViewController.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/3/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit
import Auth0

class LoginViewController: UIViewController {

    @IBAction func loginPressed(_ sender: Any) {

        // @TODO: Check if logged in? Seems to work fine tho!
        // @TODO: Settle on how "profile" scope is needed
        Auth0.webAuth()
            .scope("openid profile")
            .audience("https://peterkos.auth0.com/userinfo")
            .start { result in

                switch result {
                case .failure(let error):
                    print("Error: \(error)")
                case .success(let credentials):
                    // Auth0 auto dimsisses view
                    // @TODO: Send these to backend somehow
                    print("Credentials: \(credentials)")

                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginFinishedSegue", sender: nil)
                    }

                }
            }
    }


    // MARK: Properties
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // @FIXME: Pull user data from server after auth!
        // This is TEST DATA for now.
        user = User(name: "Joe", items: [Item(name: "Chair",  description: "it sits", uuid: UUID(), color: "", image: UIImage(), dateAdded: "", category: .Furniture),
                                         Item(name: "Desk",   description: "it sits", uuid: UUID(), color: "", image: UIImage(), dateAdded: "", category: .Furniture),
                                         Item(name: "Wallet", description: "it sits", uuid: UUID(), color: "", image: UIImage(), dateAdded: "", category: .Treasures),
                                         Item(name: "Purse",  description: "it sits", uuid: UUID(), color: "", image: UIImage(), dateAdded: "", category: .Treasures),
                                         Item(name: "Hat",    description: "it sits", uuid: UUID(), color: "", image: UIImage(), dateAdded: "", category: .Memories)])
    }

    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "loginFinishedSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginFinishedSegue") {

            // Check for MainTabBarController
            if let tabVC = segue.destination as? MainTabBarViewController {

                // Pass data to the tab bar controller, which will handle passing its own children
                // @FIXME: User error checking just before this in case login data is borked.
                tabVC.user = user!
            }
        }
    }
}
