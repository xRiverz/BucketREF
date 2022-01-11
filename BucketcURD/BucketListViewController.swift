//
//  ViewController.swift
//  BucketcURD
//
//  Created by administrator on 10/01/2022.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemDelegate {
    
    var items : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiB.getAllTasks(completionHandler: {
            data, response, error in
            
            do{
                self.items = try JSONDecoder().decode([Task].self, from: data!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print(error)
            }
        })
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].objective
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender is UIBarButtonItem{
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
        }else if sender is IndexPath {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            let indexPath = sender as! IndexPath
            let item = items[indexPath.row]
            addItemTableViewController.item = item.objective
            addItemTableViewController.indexPath = indexPath
        }
    }
        
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        apiB.deleteTask(index: items[indexPath.row].id, completionHandler: {
            data, response, error in
            
            do{
                let result = try JSONDecoder().decode([Task].self, from: data!)
                
                DispatchQueue.main.async {
                    self.items = result
                    self.tableView.reloadData()
                }
            }catch{
                print(error)
            }
            
        })
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text:String, at indexPath:IndexPath?) {
        
        if let index = indexPath {
            updateTask(index.row,text)
        }else{
            addTask(text)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addTask(_ text:String){
        apiB.addTask(objective: text, completionHandler: {
            data, response, error in
            do{
                let result = try JSONDecoder().decode([Task].self, from: data!)
                
                DispatchQueue.main.async {
                    self.items = result
                    self.tableView.reloadData()
                }
            }catch{
                print(error)
            }
        })
    }
    
    func updateTask(_ index:Int,_ text:String){
        apiB.updateTask(index: index, objective: text, completionHandler: {
            data, response, error in
            do{
                let result = try JSONDecoder().decode([Task].self, from: data!)
                
                DispatchQueue.main.async {
                    self.items = result
                    self.tableView.reloadData()
                }
            }catch{
                print(error)
            }
        })
    }
}
