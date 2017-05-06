//
//  GardenVC.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

var gardenproductArray = [product(label: "Shovel", image: #imageLiteral(resourceName: "garden-1-shovel"), price: 1.0, detail: "For shoveling."),
                            product(label: "Fruit tree", image: #imageLiteral(resourceName: "garden-5-fruit-tree"), price: 2.0, detail: "You'll never be hungry."),
                            product(label: "Soil", image: #imageLiteral(resourceName: "garden-4-garden-soil"), price: 3.0, detail: "Lots o' dirt."),
                            product(label: "Lawnmower", image: #imageLiteral(resourceName: "garden-3-mower"), price: 4.0, detail: "Nice."),
                            product(label: "Rake", image: #imageLiteral(resourceName: "garden-6-leaves-rake"), price: 5.0, detail: "For leaves."),
]

class GardenVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let updatedArray = catalogue[3]
    
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
        cell.category = 3
        cell.detail.text = updatedArray[indexPath.row].detail
        
        return cell
    }
    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "Cart", sender: self)
    }


}
