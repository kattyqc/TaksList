//
//  ViewController.swift
//  TaksList
//
//  Created by Katty Quintero on 20/5/21.
//

import UIKit

class TaksListViewController: UITableViewController {

    var item = [ItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaksListCell", for: indexPath)
        cell.textLabel?.text = item[indexPath.row].title
        
        return cell
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TaksList", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = ItemModel()
            newItem.title = textField.text!
            self.item.append(newItem)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

