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
        newItem2.title = "Сервисная книжка с отметками о продаже и печатями"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "ПТС (Паспорт Транспортного Средства) с печатями, - убедиться в отсутствии предыдущих владельцев"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Договор Купли-Продажи (не менее 2-х экземпляров) с подписями продавца и покупателя и с печатями автосалона"
        itemArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title = "Акт Приемки-Передачи. Данный акт подписывается только после осмотра и проверки автомобиля!"
        itemArray.append(newItem5)
        
        let newItem6 = Item()
        newItem6.title = "// Примечания по возможностям приложения:"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath)

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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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

