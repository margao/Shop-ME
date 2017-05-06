//
//  RecentTableViewController.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

struct recentOrder {
    var date: String!
    var orderSummary: String!
}

var recentOrderArray: [recentOrder] = []

class RecentTableViewController: UITableViewController {

    let date = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recentOrderArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath) as! RecentViewCell
        
        if recentOrderArray.count > 0 {
            cell.orderSummary.text = recentOrderArray[indexPath.row].orderSummary
            cell.date.text = recentOrderArray[indexPath.row].date
        }
        return cell
    }
 


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recentOrderArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
}
