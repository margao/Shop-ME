//
//  ViewController.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

struct groupItem {
    var category: Int
    var groupProducts = [cartItem]()
}

    var groupCart = [groupItem]()

class CartVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var decreaseQuantity: UIButton!
    @IBOutlet weak var totalSum: UILabel!
    @IBOutlet weak var totalQuant: UILabel!
    
    var numSections = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshList(notification:)), name:NSNotification.Name(rawValue: "refresh"), object: nil)
        
        refreshTotal()
        
    }

    func refreshTotal() {
        groupCart = []
        
        if globalCart.count > 0 {
            
            
            let set = NSMutableSet()
            
            for i in 0..<globalCart.count {
                set.add(globalCart[i].category)
            }
            
            numSections = set.count
            
            
            for i in 2..<sections.count {
                
                var data = [cartItem]()
                
                for j in 0..<globalCart.count{
                    if (i-2) == globalCart[j].category {
                        data.append(globalCart[j])
                    }
                }
                if data.count > 0 {
                    groupCart.append(groupItem(category: i, groupProducts: data))
                    
                }
            }
        }
        totalSum.text = String(calculateTotal())
        totalQuant.text = String(calcCartQuant())
        
    }
    
    func refreshList(notification: NSNotification){
        refreshTotal()
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupCart.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupCart[section].groupProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as!CartViewCell
        
        if globalCart.count > 0 {

            cell.label.text = groupCart[indexPath.section].groupProducts[indexPath.row].label
            cell.quantity.text = String(groupCart[indexPath.section].groupProducts[indexPath.row].quantity)
            cell.price.text = String(calculateSubTotal(section: indexPath.section, index: indexPath.row))
            cell.individualPrice = Double(groupCart[indexPath.section].groupProducts[indexPath.row].price)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sections.count {
            return sections[groupCart[section].category]
        }
        
        return nil
    }
    
    @IBAction func emptyCart(_ sender: Any) {
        globalCart = []
        viewDidLoad()
        tableView.reloadData()
        
    }
    
    func calculateTotal() -> Double {
        var total = 0.0
        for i in globalCart {
            let num = i.quantity
            let price = i.price
            
            total += Double(num!)*price!
        }
        
        return total
    }
    
    func calculateSubTotal(section: Int, index: Int) -> Double {
        let num = groupCart[section].groupProducts[index].quantity
        let price = groupCart[section].groupProducts[index].price
        
        let total = Double(num!)*price!
        return total
    }
    
    func calculateNum() -> Int {
        var total = 0
        for i in globalCart {
            let num = i.quantity
            total += num!
        }
        return total
    }
    
    @IBAction func buyCart(_ sender: Any) {
        
        let alertController = UIAlertController(title: "PAYMENT", message: "Your card will be charged $\(calculateTotal())", preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
            print("Cancelled.");
        }
        
        let temp = recentOrder(date: String(describing: NSDate()), orderSummary: "\(calculateNum()) items ($\(calculateTotal()))")
        
        let actionBuy = UIAlertAction(title: "Place Order", style: .default) { (action:UIAlertAction) in
            
            recentOrderArray.insert(temp, at: 0)
            if recentOrderArray.count > 10 {
                recentOrderArray.remove(at: 9)
            }
            globalCart = []
            self.viewDidLoad()
            self.tableView.reloadData()
        }
        
        alertController.addAction(actionCancel)
        alertController.addAction(actionBuy)
        self.present(alertController, animated: true, completion:nil)
        
    }

    @IBAction func decrease(_ sender: Any) {
        viewDidLoad()
        tableView.reloadData()
    }
    @IBAction func refreshScreen(_ sender: Any) {
        viewDidLoad()
        tableView.reloadData()
    }

    @IBAction func returnHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
}
