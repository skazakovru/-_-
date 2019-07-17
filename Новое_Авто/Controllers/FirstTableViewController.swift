//
//  FirstTableViewController.swift
//  Новое_Авто
//
//  Created by Sergei Kazakov on 7/15/19.
//  Copyright © 2019 Sergei Kazakov. All rights reserved.
//
import Foundation
import UIKit

class FirstTableViewController: UITableViewController {
    
    var itemArray = [Item]()
    
            let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist1")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Руководство по эксплуатации (инструкция)"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Руководство по эксплуатации (инструкция)"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Руководство по эксплуатации (инструкция)"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Руководство по эксплуатации (инструкция)"
        itemArray.append(newItem4)
        
        loadItems()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath)

        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Добавить новый пункт", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить пункт", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveItems()
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Создать новый пункт"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
    }
    
}
}

