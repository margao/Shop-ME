//
//  GroceryVC.swift
//  ShopME
//
//  Created by Matt Argao on 2/28/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

var groceryproductArray = [product(label: "Tomato, per lb", image: #imageLiteral(resourceName: "grocery-1-tomatoes"), price: 1.0, detail: "It's a tomato."),
                product(label: "Banana, per lb", image: #imageLiteral(resourceName: "grocery-2-bananas"), price: 2.0, detail: "It's a banana."),
                product(label: "Apple", image: #imageLiteral(resourceName: "grocery-3-gala"), price: 3.0, detail: "It's an apple."),
                product(label: "Lettuce", image: #imageLiteral(resourceName: "grocery-4-lettuce"), price: 4.0, detail: "It's lettuce."),
                product(label: "Broccoli", image: #imageLiteral(resourceName: "grocery-5-broccoli"), price: 5.0, detail: "It's broccoli."),
                product(label: "Milk", image: #imageLiteral(resourceName: "grocery-6-milk"), price: 6.0, detail: "It's milk."),
                product(label: "Bread", image: #imageLiteral(resourceName: "grocery-7-bread"), price: 7.0, detail: "It's bread."),
                product(label: "Eggs", image: #imageLiteral(resourceName: "grocery-8-eggs"), price: 8.0, detail: "It's eggs.")
]

class GroceryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let updatedArray = catalogue[0]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    @IBOutlet weak var cartTitle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshList(notification:)), name:NSNotification.Name(rawValue: "refresh"), object: nil)
        cartTitle.setTitle(String(calcCartQuant()), for: .normal)
    }

    func refreshList(notification: NSNotification){
        cartTitle.setTitle(String(calcCartQuant()), for: .normal)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        cell.category = 0
        cell.detail.text = updatedArray[indexPath.row].detail
        
        return cell
    }
    
    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "Cart", sender: self)
    }

    
}
