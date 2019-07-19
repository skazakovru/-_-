//
//  TenthTableViewController.swift
//  Новое_Авто
//
//  Created by Sergei Kazakov on 7/15/19.
//  Copyright © 2019 Sergei Kazakov. All rights reserved.
//
import Foundation
import UIKit

class TenthTableViewController: UITableViewController {

    var itemArray = [Item]()
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist10")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Сядьте в кресло водителя и отрегулируйте под себя кресло, зеркала и руль"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Если МКПП: не заводя машину, проверьте ход педалей тормоза и сцепления (педали не должны скрипеть/болтаться). Убедиться, что все передачи переключаются гладко и без усилий"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Если АКПП: не заводя машину, проверьте ход педали тормоза"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Не заводя двигатель, включить зажигание и убедиться, что лампы панели работают. Подвигать рулем вправо-влево и убедиться в отсутствии стуков"
        itemArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title = "Запустить двигатель. Убедитесь в легкости запуска без посторонних шумов, в ровной работе двигателя после пуска и в отсутствии скачков оборотов по тахометру"
        itemArray.append(newItem5)
        
        let newItem6 = Item()
        newItem6.title = "Проверить работу кондиционера/климат-контроля на максимальных режимах"
        itemArray.append(newItem6)
        
        let newItem7 = Item()
        newItem7.title = "Проверьте регулировку и складывание зеркал и электростеклоподъемников каждой двери в отдельности"
        itemArray.append(newItem7)
        
        let newItem8 = Item()
        newItem8.title = "Проверьте работу: парктроников и камер (если установлены), магнитолы, тв, включение света в салоне, свободный ход ремней безопасности"
        itemArray.append(newItem8)
        
        let newItem9 = Item()
        newItem9.title = "Выйдите из машины и посадите менеджера на место водителя. Попросите его поочередно включить аварийную сигнализацию, поворотники, ближний/дальний свет, габариты, стопы, задние и передние противотуманные фары"
        itemArray.append(newItem9)
        
        let newItem10 = Item()
        newItem10.title = "Примечание: Если при проверки обнаружены дефекты/неисправности, то вы вправе требовать их устранения, или отказаться от покупки и вернуть уплаченную сумму."
        itemArray.append(newItem10)
        
       
        loadItems()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "J", for: indexPath)
        
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
