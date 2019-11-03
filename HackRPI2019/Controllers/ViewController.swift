//
//  ViewController.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/2/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit
import SwiftyJSON


// @FIXME: THIS.
// DEAD CODE FOR NOW
// Will refactor out piece by piece into view controllers that better
// represent the individual functionality that this monolithic class did all at once.


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBAction func takePicture(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }

    // MARK: Properties
    var imagePicker = UIImagePickerController()
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize and configure image picker
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
                self.performSegue(withIdentifier: "pictureDetailSegue", sender: nil)
            }

        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        if let detailVC = segue.destination as? PictureDetailViewController {

            guard image != nil else {
                print("ERROR: No image available.")
                return
            }

            detailVC.image = self.image!
            print("Sending image")
        }

    }


}

