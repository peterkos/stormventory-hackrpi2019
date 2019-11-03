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

            let base64Image = self.image?.jpegData(compressionQuality: 0.0)!.base64EncodedString()

            // Same API I guess #backend amirite
            let url = URL(string: "http://167.71.252.89:8000/api/items/")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let json = JSON(base64Image)
            print("json: \(json)")

            request.httpBody = try? JSONSerialization.data(withJSONObject: ["image": base64Image], options: [])


            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }

            print("about to post")
            // Post to server
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                // Send data to next VC
                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "pictureDetailSegue", sender: nil)
                    self.sendDataBack()
                    print("sending data back!")
                }
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
