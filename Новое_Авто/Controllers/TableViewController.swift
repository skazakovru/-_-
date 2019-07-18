//
//  TBVC.swift
//  Новое_Авто
//
//  Created by Sergei Kazakov on 7/15/19.
//  Copyright © 2019 Sergei Kazakov. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    var itemArray = [String]()
    var identities = [String]()
    
    override func viewDidLoad() {
        
        itemArray = ["Документы","Маркировка","Комплектация","Дополнительное оборудование","Колеса","Внешний осмотр","Кузов и его элементы","Уровень технических жидкостей","Осмотр салона","Проверка основных узлов и агрегатов"]
        identities = ["A","B","C","D","E","F","G","H","I","J"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = itemArray[indexPath.row]
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.font = UIFont (name: "Avenir Next", size: 19)
        cell?.textLabel?.textColor = #colorLiteral(red: 0.9592440724, green: 0.965782702, blue: 0.9719859958, alpha: 1)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationController?.pushViewController(viewController!, animated: true)

    }
    
}
