//
//  TBVC.swift
//  Новое_Авто
//
//  Created by Sergei Kazakov on 7/15/19.
//  Copyright © 2019 Sergei Kazakov. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class TableViewController: UITableViewController, SKPaymentTransactionObserver {

    
    let productID = "com.rigpet.CheckNewCar.itemArrayPremium"
    
    var itemArrayToShow = [String]()
    var itemArrayPremium = [String]()
    var identities = [String]()
    
    override func viewDidLoad() {
        
        SKPaymentQueue.default().add(self)
        
        if isPurchased() {
            showPremiumContent()
        }
        
        itemArrayToShow = ["Документы","Маркировка","Комплектация","Дополнительное оборудование","Внешний осмотр","Колеса"]
        
        itemArrayPremium = ["Кузов и его элементы","Уровень технических жидкостей","Осмотр салона","Проверка основных узлов и агрегатов"]
        
        identities = ["A","B","C","D","E","F","G","H","I","J"]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isPurchased() {
            return itemArrayToShow.count
        } else {
            return itemArrayToShow.count + 1
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if indexPath.row < itemArrayToShow.count{
        cell?.textLabel?.text = itemArrayToShow[indexPath.row]
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.font = UIFont (name: "Helvetica Neue", size: 19)
        cell?.textLabel?.textColor = #colorLiteral(red: 0.9592440724, green: 0.965782702, blue: 0.9719859958, alpha: 1)
       
        } else {
            cell?.textLabel?.text = "Загрузить полную версию"
            cell?.textLabel?.textColor = #colorLiteral(red: 0.1176470588, green: 0.8901960784, blue: 0.8117647059, alpha: 1)
            cell?.accessoryType = .disclosureIndicator
        }
        
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == itemArrayToShow.count {
            buyPremium()
        }
        
        let vcName = identities[indexPath.row]
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationController?.pushViewController(viewController!, animated: true)

    }
    
    // Mark: - In-App Purchase Methods
    
    func buyPremium() {
        if SKPaymentQueue.canMakePayments() {
            
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            print("User can't make payments")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //User payment successful
                print("Transaction successful!")
                
                showPremiumContent()
                
               
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                
                //Payment failed
                
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed due to error: \(errorDescription)")
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .restored {
                
                showPremiumContent()
                
                print("Transaction restored")
                
                navigationItem.setRightBarButton(nil, animated: true)
                
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    func showPremiumContent() {
        
        UserDefaults.standard.set(true, forKey: productID)
        
        itemArrayToShow.append(contentsOf: itemArrayPremium)
        tableView.reloadData()
    }
    
    func isPurchased() -> Bool {
        let purchaseStatus = UserDefaults.standard.bool(forKey: productID)
        
        if purchaseStatus {
            print("Previously purchased")
            return true
        } else {
            print("Never purchased")
            return false
        }
    }
    
    @IBAction func restoreButton(_ sender: UIBarButtonItem) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}
