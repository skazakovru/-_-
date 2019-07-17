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
        

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row].title 

        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    


}
