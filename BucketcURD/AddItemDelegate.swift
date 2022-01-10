//
//  AddItemDelegate.swift
//  BucketcURD
//
//  Created by administrator on 10/01/2022.
//

import Foundation
import UIKit

protocol AddItemDelegate : class {
    func itemSaved(by controller:AddItemTableViewController, with text:String, at indexPath: IndexPath?)
    func cancelButtonPressed(by controller:AddItemTableViewController)
}
