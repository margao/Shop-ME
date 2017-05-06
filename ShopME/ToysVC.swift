//
//  ToysVC.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

var toysproductArray = [product(label: "Plushie Pikachu", image: #imageLiteral(resourceName: "1014587_us_toys_favorite_characters_q4__shop-by-tile_416x560_pokemon"), price: 3.20, detail: "Pika pika!"),
                              product(label: "Weird Toy Pack", image: #imageLiteral(resourceName: "FW1S-Baby-Toys-Rattle-Tinkle-Hand-Bell-Multifunctional-Plush-Stroller.jpg_350x350"), price: 3.08, detail: "Strange..."),
                              product(label: "Toy Guitar", image: #imageLiteral(resourceName: "pTRU1-17974023enh-z6"), price: 1.03, detail: "Dragonforce"),
                              product(label: "Extreme Tea Party Set", image: #imageLiteral(resourceName: "51gLr0Yz+nL._SY355_"), price: 2.23, detail: "Radical"),
                              product(label: "Mr. Patoots Head", image: #imageLiteral(resourceName: "Most-Popular-Toys-Throughout-History"), price: 1.67, detail: "Definitely not Toy Story"),
]

class ToysVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let updatedArray = catalogue[7]
    
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
        cell.category = 7
        cell.detail.text = updatedArray[indexPath.row].detail
        
        return cell
    }

    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "Cart", sender: self)
    }
}
