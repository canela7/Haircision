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

class RegisterViewController: UIViewController, UITextFieldDelegate {

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
    
    }
    
    //MARK: Texfield methods
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameTextField {
            emailTextField.becomeFirstResponder()
        }else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField  {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomePage" {
            if let destinationVC = segue.destination as? HomePageViewController
            {
                destinationVC.fullNameString = Auth.auth().currentUser?.displayName
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
                
//                self.createdUserDataBase()
//
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
    
}


