//
//  HaircutSelectionViewController.swift
//  Haircision
//
//  Created by Brian Canela on 5/31/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import Firebase

class HaircutSelectionViewController: UITableViewController {

        
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "haircutTypes", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func logOutPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("Log out succ")
        }catch{
            print("Error: there was a problem loggin out")
        }
        
        guard (navigationController?.popToRootViewController(animated: true)) != nil else {
            print("No view controllers to pop off")
            return
        }
        
    }
    
    
    

}
