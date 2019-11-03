//
//  TakePictureViewController.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/3/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import VisualRecognition

class TakePictureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UserDataHandler {

    @IBAction func takePicture(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }

    // MARK: Properties
    var user: User!
    var imagePicker = UIImagePickerController()
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup image picker
        imagePicker.delegate = self
        imagePicker.sourceType = .camera

        // Bottom bar icon and title
        // @FIXME: Add custom icon, this does not run as-is.
        self.tabBarItem.title = "Add Item"
    }
    

   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // Save image data to property
        image = info[.originalImage] as? UIImage

        // Hide view
        imagePicker.dismiss(animated: true) {

            DispatchQueue.main.async {
                SVProgressHUD.show()
            }

            let authenticator = WatsonIAMAuthenticator(apiKey: "Jff39czKgef-lHclSkj4AOT49oYOSNECQR0ANMdRsPcy")
            let visReg = VisualRecognition(version: "2019-11-02", authenticator: authenticator)
            visReg.serviceURL = "https://gateway.watsonplatform.net/visual-recognition/api"

            guard self.image != nil else {
                print("No image, boss")
                return
            }

            visReg.classify(image: self.image!, threshold: 0.5, owners: ["me"], classifierIDs: ["default"], acceptLanguage: "en") { (response, error) in
                guard error == nil else {
                      print(error)
                      return
                  }

                  print("Headers")
                  print(response?.headers)
                  print("Result")
                  print(response?.result)

            }



        }

    }

    // Precondition: called from main thread
    func sendDataBack() {

        SVProgressHUD.setHapticsEnabled(true)
        SVProgressHUD.show()

        guard image != nil else {
            print("ERROR: No image available.")
            return
        }

        let storageVC = tabBarController?.viewControllers?.first?.children.first as! StorageCollectionViewController

        // @TODO: Upload picture and get data, fill in from below
//            storageVC.user.items.append(Item())

        // Update data model in "destination" VC
        storageVC.user = self.user

        // Move back to other tab
        tabBarController?.selectedIndex = 0

        SVProgressHUD.showSuccess(withStatus: "Image analyzed!")
        SVProgressHUD.dismiss(withDelay: 1)


    }


}
