//
//  ViewController.swift
//  ShopME
//
//  Created by Matt Argao on 2/28/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

struct category {
    var label: String!
    var buttonImage: UIImage!
}

struct cartItem {
    var label: String!
    var price: Double!
    var quantity: Int!
    var category: Int!
}

struct product {
    var label: String!
    var image: UIImage!
    var price: Double!
    var detail: String!
}

var globalCart = [cartItem]()

func calcCartQuant() -> Int {
    var total = 0
    if globalCart.count > 0 {
        for i in globalCart {
            total += i.quantity
        }
    }
    return total
}

var sections = ["Recent", "Cart", "Grocery", "Clothing", "Movies", "Garden", "Electronics", "Books", "Appliances", "Toys"]

var catalogue = [ groceryproductArray, clothingproductArray, moviesproductArray, gardenproductArray, electronicsproductArray, booksproductArray, appliancesproductArray, toysproductArray]

var categoryArray = [ category(label: "Recent Orders", buttonImage: #imageLiteral(resourceName: "category-1-recent")),
                              category(label: "Cart(\(calcCartQuant()))", buttonImage: #imageLiteral(resourceName: "category-2-cart")),
                              category(label: "Grocery", buttonImage: #imageLiteral(resourceName: "category-3-grocery")),
                              category(label: "Clothing", buttonImage: #imageLiteral(resourceName: "category-4-clothing")),
                              category(label: "Movies", buttonImage: #imageLiteral(resourceName: "category-5-movies")),
                              category(label: "Garden", buttonImage: #imageLiteral(resourceName: "category-6-garden")),
                              category(label: "Electronics", buttonImage: #imageLiteral(resourceName: "category-7-electronics")),
                              category(label: "Books", buttonImage: #imageLiteral(resourceName: "category-8-books")),
                              category(label: "Appliances", buttonImage: #imageLiteral(resourceName: "category-9-appliances")),
                              category(label: "Toys", buttonImage: #imageLiteral(resourceName: "category-10-toys"))]

class CollectionViewController: UICollectionViewController {

    
    @IBOutlet weak var managerButton: UIBarButtonItem!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryArray[1].label = "Cart(\(calcCartQuant()))"
        
        let logo = #imageLiteral(resourceName: "logo")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        let bgImage = UIImageView();
        bgImage.image = #imageLiteral(resourceName: "background-home")
        bgImage.contentMode = .scaleToFill
        bgImage.alpha = 0.5
        
        self.collectionView?.backgroundView = bgImage
    }

    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
        collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        findSegue(index: indexPath.row)
    }
    
    func findSegue(index: Int) {
        if index < 10 {
        let segue = sections[index]
        
        performSegue(withIdentifier: segue, sender: self)
        } else {
           //Couldn't figure out how to programatically create a storyboard and segue...
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as UICollectionViewCell
        
        let textLabel = cell.viewWithTag(1) as! UILabel
        textLabel.text = categoryArray[indexPath.row].label
        
        let imageView = cell.viewWithTag(2) as! UIImageView
        imageView.image = categoryArray[indexPath.row].buttonImage
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return cell
        
    }

    @IBAction func goToManager(_ sender: Any) {
        performSegue(withIdentifier: "Manager", sender: self)
    }

    
}

