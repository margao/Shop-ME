//
//  ProductViewCell.swift
//  ShopME
//
//  Created by Matt Argao on 2/28/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit


class ProductViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var detail: UILabel!
 

    
    var category: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if globalCart.count > 0 {
            var add = true
            
            for i in 0..<globalCart.count {
                if globalCart[i].label == productLabel.text {
                    let old = globalCart[i].quantity
                    globalCart[i].quantity = old! + 1
                    add = false
                }
            }
            if add {
                globalCart.append(cartItem(label: productLabel.text, price: Double(productPrice.text!), quantity: 1, category: category))
            }
            
            
        } else {
            globalCart.append(cartItem(label: productLabel.text, price: Double(productPrice.text!), quantity: 1, category: category))
        }
        
        self.setNeedsDisplay()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
    }
}
