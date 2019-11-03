//
//  TakePictureViewController.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/3/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit
import SVProgressHUD

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

        imagePicker.delegate = self
        imagePicker.sourceType = .camera
    }
    

   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // Save image data to property
        image = info[.originalImage] as? UIImage

        // Hide view
        imagePicker.dismiss(animated: true) {

            // Show next VC
            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "pictureDetailSegue", sender: nil)
                self.sendDataBack()
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
