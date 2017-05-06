//
//  ElectronicsVC.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

var electronicsproductArray = [product(label: "NES", image: #imageLiteral(resourceName: "NES"), price: 100.00, detail: "Old fashioned."),
                          product(label: "Xbox One", image: #imageLiteral(resourceName: "58485-xbox-one-box"), price: 200.00, detail: "Microsoft"),
                          product(label: "Sega Genesis", image: #imageLiteral(resourceName: "Best_Selling_Video_Game_Consoles_4707_5290.jpg"), price: 500.00, detail: "Play Sonic."),
                          product(label: "PS4", image: #imageLiteral(resourceName: "635838776599048097-XXX-112013SHOP-THANKSGIVING-TECH004"), price: 432.76, detail: "Sony"),
                          product(label: "Slim PS4", image: #imageLiteral(resourceName: "gallery-1476881967-sony-playstation-4-slim"), price: 500.01, detail: "Skinny PS4"),
]

class ElectronicsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let updatedArray = catalogue[4]
    
    @IBOutlet weak var cartButton: UIBarButtonItem!
    @IBOutlet weak var cartTitle: UIButton!
    
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
        cell.category = 4
        cell.detail.text = updatedArray[indexPath.row].detail
        
        return cell
    }
    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "Cart", sender: self)
    }
}
