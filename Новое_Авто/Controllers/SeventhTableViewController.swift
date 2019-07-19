//
//  SeventhTableViewController.swift
//  Новое_Авто
//
//  Created by Sergei Kazakov on 7/15/19.
//  Copyright © 2019 Sergei Kazakov. All rights reserved.
//
import Foundation
import UIKit

class SeventhTableViewController: UITableViewController {

    var itemArray = [Item]()
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist7")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Измерить толщиномером каждую деталь кузова в 2-х местах - разница не должна превышать 100 микрон, а толщина краски должна быть не более 170 микрон"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Открыть двери, капот и багажник и убедиться, убедиться, что все петли и болты не имеют следов демонтажа"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Багажник: убедиться в отсутствии повреждений металла в месте крепления запасного колеса/докатки"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Под капотом: убедиться в отсутствии повреждений передней панели радиатора и ребер жесткости слева и справа от двигателя"
        itemArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title = "Стекла: убедиться, что год выпуска всех стекол совпадает и отсутствуют повреждения стекл"
        itemArray.append(newItem5)
        
        let newItem6 = Item()
        newItem6.title = "О всех найденных дефектах сделать отметку в акте Приемки-Передачи"
        itemArray.append(newItem6)
    
           
        loadItems()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "G", for: indexPath)
        
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
