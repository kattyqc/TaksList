//
//  ViewController.swift
//  TaksList
//
//  Created by Katty Quintero on 20/5/21.
//

import UIKit

class TaksListViewController: UITableViewController {

    var item = [ItemModel]()
    //file path to save data
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaksListCell", for: indexPath)
        let items = item[indexPath.row]
        cell.textLabel?.text = item[indexPath.row].title
        
        cell.accessoryType = items.done == true ? .checkmark : .none
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        item[indexPath.row].done = !item[indexPath.row].done
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TaksList", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = ItemModel()
            newItem.title = textField.text!
            self.item.append(newItem)
            
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do { //Here data codifing and save in created path
            let data = try encoder.encode(item)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: self.dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                item = try decoder.decode([ItemModel].self, from: data)
            } catch {
                print("Error decoding item, \(error)")
            }
            self.tableView.reloadData()
        }
    }
}

