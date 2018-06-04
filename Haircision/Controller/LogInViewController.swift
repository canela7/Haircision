//
//  LogInViewController.swift
//  Haircision
//
//  Created by Brian Canela on 6/1/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        signUpButton.layer.cornerRadius = 8.0
        signUpButton.layer.masksToBounds = true
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.alpha = 0.0
        passwordTextField.alpha = 0.0
        
        loginButton.center.y += 10.0
        loginButton.alpha = 0.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


        UIView.animate(withDuration: 0.3, delay: 0.2, options: [], animations: {
            self.emailTextField.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: [], animations: {
            self.passwordTextField.alpha = 1.0
        }, completion: nil)
        
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y -= 10.0
            self.loginButton.alpha = 1.0
        }, completion: nil)

    }
    

    @IBAction func logInPressed(_ sender: Any) {
        
        guard let email = emailTextField.text else {
            print("Error with email input")
            return
        }
        
        guard let password = passwordTextField.text else {fatalError("no password found")}
        
        //loading indicator effect
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                
                UIView.animate(withDuration: 5, animations: {
                    SVProgressHUD.dismiss()
                })
                
                print("Error login in: \(error!.localizedDescription)")
                
                let alert = UIAlertController(title: "Error Login In", message: "Check email and password", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Return", style: .default, handler: { (action) in
                    print("Returned back to login")
                }))
                
              self.present(alert, animated: true, completion: nil)
                
                
            }else {
                print("Login Successful!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToHomePage", sender: self)
            }
        }
        
    }
    

 
    


}
