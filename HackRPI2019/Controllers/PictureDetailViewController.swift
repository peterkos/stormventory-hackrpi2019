//
//  PictureDetailViewController.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/2/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit

class PictureDetailViewController: UIViewController {


    // MARK: IBOutlets and IBActions
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!

    // MARK: Properties
    var image: UIImage!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print(self.image!)
        imageView.image = self.image!
    }


}
