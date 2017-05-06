//
//  MoviesVC.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

var moviesproductArray = [product(label: "Grey", image: #imageLiteral(resourceName: "grey-movie-poster"), price: 5.00, detail: "Starring Liam Neeson"),
                            product(label: "The Godfather", image: #imageLiteral(resourceName: "movies-3-godfather"), price: 7.08, detail: "Directed by Ford Coppola"),
                            product(label: "Rocky V", image: #imageLiteral(resourceName: "15-misleading-movie-posters-rocky-v"), price: 5.03, detail: "Starring Sylvester Stallone"),
                            product(label: "The Lord of the Rings", image: #imageLiteral(resourceName: "movies-2-lord-of-the-rings"), price: 4.23, detail: "Directed by Peter Jackson"),
                            product(label: "Shawshank Redemption", image: #imageLiteral(resourceName: "movies-1-shawshank"), price: 5.67, detail: "Directed by Frank Darabont"),
]

class MoviesVC: UIViewController, UITableViewDataSource, UITableViewDelegate   {

    let updatedArray = catalogue[2]
    
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
        cell.category = 2
        cell.detail.text = updatedArray[indexPath.row].detail
        
        return cell
    }

    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "Cart", sender: self)
    }

}
