//
//  HomePageViewController.swift
//  Haircision
//
//  Created by Brian Canela on 6/3/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import Firebase

class HomePageViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet weak var barbershopName: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    //var to pass in the full name!
    var fullNameString: String!
    var fullName: UserModel?
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    var barbershopsData = ["1 Slauson", "PicoCutz", "MensHairDone","Clean Cuts"]
    
    
    var barbershopData: [BarbershopModel] = [BarbershopModel] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let width = (view.frame.size.width)
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: width, height: width)
        
        fullNameLabel.text =  Auth.auth().currentUser?.displayName
        
        retrieveBarbershopData();
        
        
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addBarbershopPressed(_ sender: Any) {
        
        //to read and write data from database,
        let barbershopsDB = Database.database().reference().child("Barbershops")
        
        
        let barberDictionary = ["Sender": Auth.auth().currentUser?.email, "BarbershopName": barbershopName.text! , "BarbershopAddress": addressTextField.text!]
        
        barbershopsDB.childByAutoId().setValue(barberDictionary){
            (error, reference) in
            
            if error != nil {
                print(error!.localizedDescription)
            }else {
                print("SENT TO DATABASE")
                self.barbershopName.text = ""
                self.addressTextField.text = ""
            }
        }
    }
    

    func retrieveBarbershopData() {
        let barbershopDB = Database.database().reference().child("Barbershops")
        
        
        barbershopDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let sender = snapshotValue["Sender"]!
            let barbershopName = snapshotValue["BarbershopName"]!
            let barbershopLocation = snapshotValue["BarbershopAddress"]!
            
            print(sender, barbershopName, barbershopLocation)
            
            print(snapshotValue)
            
            let barbershopData = BarbershopModel()
            barbershopData.barbershopName = barbershopName
            barbershopData.address =  barbershopLocation
            
            self.barbershopData.append(barbershopData)
            
            self.collectionView.reloadData()
            
            
        }
        
        
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedBarbershop" {
            if let destinationVC = segue.destination as? BarbershopSelectedViewController
            {
                if let index = collectionView.indexPathsForSelectedItems?.first {
                  destinationVC.selection = barbershopData[index.row].barbershopName
                }
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{
            print("Log Out Failed")
        }
        
        guard (navigationController?.popToRootViewController(animated: true)) != nil else {
            print("No view controllers to pop off")
            return
        }
    }
    
    
}


extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return barbershopData.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) 
        
        
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = barbershopData[indexPath.row].barbershopName
        }

        
        
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectedBarbershop", sender: self)
    }

}




