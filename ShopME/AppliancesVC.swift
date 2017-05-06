//
//  AppliancesVC.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

var appliancesproductArray = [product(label: "Dishwasher", image: #imageLiteral(resourceName: "rsi-rmt-Dishwasher-708-HomeAppliancesPFS-62216"), price: 53.20, detail: "Samsung"),
                         product(label: "Refridgerator", image: #imageLiteral(resourceName: "refrigerators-12g"), price: 32.08, detail: "XL Size"),
                         product(label: "Coffee Maker", image: #imageLiteral(resourceName: "single-serve-coffee-maker"), price: 61.03, detail: "Single Serve"),
                         product(label: "Vacuum Cleaner", image: #imageLiteral(resourceName: "10-Luxury-Kitchen-Appliances-That-Are-Worth-Your-Money-5b"), price: 442.23, detail: "High sucking action"),
                         product(label: "Microwave", image: #imageLiteral(resourceName: "images-2"), price: 221.67, detail: "For non-cooks"),
]

class AppliancesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let updatedArray = catalogue[6]
    
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
        cell.category = 6
        cell.detail.text = updatedArray[indexPath.row].detail
        
        return cell
    }

    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "Cart", sender: self)
    }
}
