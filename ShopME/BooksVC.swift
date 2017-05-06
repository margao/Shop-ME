//
//  BooksVC.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

var booksproductArray = [product(label: "The Great Gatsby", image: #imageLiteral(resourceName: "the-great-gatsby"), price: 5.20, detail: "F. Scott Fitzgerald"),
                          product(label: "Clifford The Big Red Dog", image: #imageLiteral(resourceName: "5b16496ed88d890c3f0b65f5c9db46e7"), price: 3.08, detail: "Norman Bridwell"),
                          product(label: "1984", image: #imageLiteral(resourceName: "book-covers-41"), price: 6.03, detail: "George Orwell"),
                          product(label: "A Clockwork Orange", image: #imageLiteral(resourceName: "book-covers-18"), price: 44.23, detail: "Anthony Burgess"),
                          product(label: "Lifeboat", image: #imageLiteral(resourceName: "GR-lifeboat"), price: 21.67, detail: "Charlotte Rogan"),
]

class BooksVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    let updatedArray = catalogue[5]
    
    @IBOutlet weak var cartTitle: UIButton!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
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
        // Dispose of any resources that can be recreated.
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
        cell.category = 5
        cell.detail.text = updatedArray[indexPath.row].detail
        
        return cell
    }

    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "Cart", sender: self)
    }
}
