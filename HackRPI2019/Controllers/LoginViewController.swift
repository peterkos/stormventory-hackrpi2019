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


        // @TODO: Check for login
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
                    self.performSegue(withIdentifier: "loginFinishedSegue", sender: nil)
                }
            }
        

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}
