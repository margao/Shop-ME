//
//  ClothingVC.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

var clothingproductArray = [product(label: "Jeans", image: #imageLiteral(resourceName: "clothing-4"), price: 1.0, detail: "Really skinny jeans."),
                                    product(label: "Yeezy Shoes", image: #imageLiteral(resourceName: "clothing-1"), price: 2.0, detail: "Yeezy."),
                                    product(label: "Nike Shoes", image: #imageLiteral(resourceName: "clothing-2"), price: 3.0, detail: "Nike Huarache."),
                                    product(label: "Jacket", image: #imageLiteral(resourceName: "clothing-5"), price: 4.0, detail: "Cozy."),
                                    product(label: "T-shirt", image: #imageLiteral(resourceName: "clothing-3"), price: 5.0, detail: "Pikachu."),
]

class ClothingVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    let updatedArray = catalogue[1]
    
    @IBOutlet weak var cartTitle: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshList(notification:)), name:NSNotification.Name(rawValue: "refresh"), object: nil)
        cartTitle.setTitle(String(calcCartQuant()), for: .normal)
    }
    
    
    func refreshList(notification: NSNotification){
        cartTitle.setTitle(String(calcCartQuant()), for: .normal)
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updatedArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as!ProductViewCell
        
        cell.productImage.image = updatedArray[indexPath.row].image
        cell.productLabel.text = updatedArray[indexPath.row].label
        cell.productImage?.contentMode = UIViewContentMode.scaleAspectFit
        cell.productPrice.text = String(updatedArray[indexPath.row].price!)
        cell.category = 1
        cell.detail.text = updatedArray[indexPath.row].detail
        
        return cell
    }
    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "Cart", sender: self)
    }


}
