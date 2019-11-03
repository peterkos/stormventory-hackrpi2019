//
//  User.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/3/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit

protocol UserDataHandler {
    var user: User! { get set }
}

struct User {
    var name: String
    var items: [Item]
}

struct Item {
    var name: String
    var description: String
    var uuid: UUID
    var color: String
    var image: UIImage
    var dateAdded: String //@TODO: Parse to date lol
    var category: Category
}

// @TODO: Add more categories, define them better
// @TODO: Let user add custom categories!
enum Category: CaseIterable {
    case Furniture
    case Treasures
    case Memories
}
