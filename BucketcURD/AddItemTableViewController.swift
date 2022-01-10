//
//  AddItemTableViewController.swift
//  BucketcURD
//
//  Created by administrator on 10/01/2022.
//



import UIKit

class AddItemTableViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var item : String?
    var indexPath : IndexPath?
    
    weak var delegate:AddItemDelegate?
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by:self)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = textField.text!
        delegate?.itemSaved(by: self, with: text, at: indexPath)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = item
    }
}
