//
//  CartViewCell.swift
//  ShopME
//
//  Created by Matt Argao on 3/1/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

class CartViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var increaseButton: UIButton!

    var individualPrice = 0.0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    func calculateSubTotal() -> Double {
        let num = Double(quantity.text!)
        let p = individualPrice
        
        let total = Double(num!)*p
        return total
    }
    
    @IBAction func increaseQuant(_ sender: Any) {
        let oldValue = Int(quantity.text!)
        let newValue = oldValue! + 1
        
        quantity.text = String(newValue)
        
        for i in 0..<globalCart.count {
            if (label.text == globalCart[i].label) {
                globalCart[i].quantity = newValue
            }
        }
        
        price.text = String(calculateSubTotal())
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    @IBAction func decreaseQuant(_ sender: Any) {
        let oldValue = Int(quantity.text!)
        let newValue = oldValue! - 1
        
        if (newValue > 0) {
            quantity.text = String(newValue)
            
            for i in 0..<globalCart.count {
                if (label.text == globalCart[i].label) {
                    globalCart[i].quantity = newValue
                }
            }
        } else {
            for i in 0..<globalCart.count {
                if (label.text == globalCart[i].label) {
                    globalCart.remove(at: i)
                    break
                }
            }
        }
        price.text = String(calculateSubTotal())
        let tableView = self.superview?.superview as! UITableView
        tableView.reloadData()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)

    }
    
}
