//
//  LoginViewController.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/3/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit
import Auth0
import SwiftyJSON

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

                    self.getUserData()

                }
            }
    }


    // MARK: Properties
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        // @FIXME: Testing. Skip login by uncommenting below.
//        getUserData()

        user = User(name: "Joeb", items: [Item(name: "asdf", description: "desc", uuid: UUID(), color: "afs", image: "", dateAdded: "s", category: .Other)])
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

    // MARK: Functions

    func getUserData() {

        // NETWORK THINGS
        let url = URL(string: "http://167.71.252.89:8000/api/items/")!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            // Attempt to convert json
            var json: JSON
            do {
                json = try JSON(data: data!)
            } catch {
                print("Unable to convert json")
                return
            }

            // Json output
            print(json)

            // Jump down a level
            json = json[0]

            // Manually build the item
            // @FIXME: Update as database is updated
            // @TODO: Parse date
            // @TODO: Parse UUID safely (a.k.a. make backend generate correct ones all the time)
            let item = Item(name: json["name"].stringValue,
                            description: json["description"].stringValue,
                            uuid: UUID(),
                            color: json["color"].stringValue,
                            image: json["image"].stringValue,
                            dateAdded: json["created_at"].stringValue,
                            category: .Other)


            // Create dummy user with just this one item for now
            let user = User(name: "Bach", items: [item])
            print(user)

            // Pass it forward!
            self.user = user

            // Go to next screen
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginFinishedSegue", sender: nil)
            }


        }.resume()
    }
}
