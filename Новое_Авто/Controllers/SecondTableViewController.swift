//
//  SecondTableViewController.swift
//  Новое_Авто
//
//  Created by Sergei Kazakov on 7/15/19.
//  Copyright © 2019 Sergei Kazakov. All rights reserved.
//
import Foundation
import UIKit

class SecondTableViewController: UITableViewController {

    var itemArray = [Item]()
    
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Выяснить все места нанесения маркировки в автомобиле"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Убедиться, что маркировка чистая и легко читается"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Сверить номера VIN кода двигателя и номер кузова с номерами в ПТС и договоре Купли-Продажи"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Примечание: представитель ГИБДД может и не знать, где находится маркировка, что может привести к задержке процесса установки автомобиля на учет."
        itemArray.append(newItem4)
        
        
        let newItem6 = Item()
        newItem6.title = ""
        itemArray.append(newItem6)
        
        let newItem7 = Item()
        newItem7.title = "* Завершенные пункты отмечаются галочками касанием соответствующей строки и снимаются повторным касанием."
        itemArray.append(newItem7)
        
        let newItem8 = Item()
        newItem8.title = "* Если нажать на '+' в верхней части экрана, то можно добавить дополнительный пункт."
        itemArray.append(newItem8)
        
        let newItem9 = Item()
        newItem9.title = "* Любой пункт можно безвозвратно удалить движением пальца по страке справа налево."
        itemArray.append(newItem9)
        
        let newItem10 = Item()
        newItem10.title = "* Все изменения сохраняются автоматически и остаются в памяти устройства даже после перезагрузки."
        itemArray.append(newItem10)
        
        loadItems()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "B", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.font = UIFont (name: "Helvetica Neue", size: 15)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = #colorLiteral(red: 0.03801516443, green: 0.3190023005, blue: 0.4801079631, alpha: 1)
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            itemArray[indexPath.row].done = !itemArray[indexPath.row].done
            
            saveItems()
            
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            itemArray.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            saveItems()
            
        }
    }

    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить к списку", style: .default) { (action) in
            
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
    

