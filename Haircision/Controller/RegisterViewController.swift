//
//  RegisterViewController.swift
//  Haircision
//
//  Created by Brian Canela on 6/1/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var goToLoginButton: UIButton!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var userData: UserModel?
    
     var userDatas: [UserModel] = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = 8.0
        signUpButton.layer.masksToBounds = true
        
        goToLoginButton.layer.cornerRadius = 8.0
        goToLoginButton.layer.masksToBounds = true
        
        retrieveuserData()
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomePage" {
            if let destinationVC = segue.destination as? HomePageViewController
            {
                destinationVC.fullNameString = Auth.auth().currentUser?.uid
            }
        }
    }

    
    @IBAction func signUpPressed(_ sender: Any) {
        //Set up a new user on our firebase database.
        
        guard let fullName = fullNameTextField.text else {return}
        
        guard let email = emailTextField.text else {fatalError("no email found")}
        guard let password = passwordTextField.text else {fatalError("no password found")}
        
        //loading indicator show effect
        SVProgressHUD.show()
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                print("User Created, Registraation completed")
                
                self.createdUserDataBase()
        
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToHomePage", sender: self)
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = fullName
                changeRequest?.commitChanges(completion: { (error) in
                    if error == nil {
                        print("User displayed a changed!")
                    }
                })
                
            }else{
                print("Error creating user: \(error!.localizedDescription)")
            }
        }
    }
    
    
    func createdUserDataBase() {
        
        let userDB = Database.database().reference().child("userCreated")
        
        let userDictionary = ["fullName": fullNameTextField.text! , "email": emailTextField.text!]
        
        userDB.childByAutoId().setValue(userDictionary) {
            (error, reference) in
            if error != nil {
                print(error!.localizedDescription)
            }else {
                print("user database sent to firebase!")
            }
        }
    }
    
    
    
    func retrieveuserData() {
      let userDB = Database.database().reference().child("userCreated")
        
        
        userDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            
            let userFullName = snapshotValue["fullName"]!
            let userEmail = snapshotValue["email"]!
            
            
            let userData = UserModel()
            userData.fullName = userFullName
            userData.userEmail = userEmail

            self.userDatas.append(userData)

            
            print(userFullName, userEmail)
            
            print(snapshotValue)
            }
        
    }
    
    
    
    
    

    
    
    
}
