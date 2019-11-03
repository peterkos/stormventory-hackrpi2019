//
//  StorageCollectionViewController.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/3/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit
import VegaScrollFlowLayout

private let reuseIdentifier = "itemCell"

class StorageCollectionViewController: UICollectionViewController, UserDataHandler {


    // MARK: Properties
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = VegaScrollFlowLayout()
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: collectionView.frame.width - 40, height: 350)
        layout.sectionInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)

        self.collectionView.collectionViewLayout = layout

        // @FIXME: This doens't like me, top bar now looks weird :c
        edgesForExtendedLayout = [.bottom]
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // Filter out items of each corresponding section type
        return user.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
    
        cell.imageView.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.2784313725, blue: 0.3450980392, alpha: 1)
        cell.imageView.layer.masksToBounds = true
        cell.backgroundColor = .white

        cell.layer.cornerRadius = 8

        let shadowPath = UIBezierPath(rect: cell.bounds)
//        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowPath = shadowPath.cgPath

        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
