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
        
        itemArray = ["Документы","Маркировка","Комплектация","Дополнительное оборудование","Колеса","Внешний осмотр","Кузов и его элементы","Уровень технических жидкостей","Осмотр салона","Проверка работоспособности основных узлов и агрегатов автомобиля"]
        identities = ["A","B","C","D","E","F","G","H","I","J"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = itemArray[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
}
