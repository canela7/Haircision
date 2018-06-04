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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = 8.0
        signUpButton.layer.masksToBounds = true
        
        goToLoginButton.layer.cornerRadius = 8.0
        goToLoginButton.layer.masksToBounds = true
        
        
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
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToHaircutSelections", sender: self)
                
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
    

}
