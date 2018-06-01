//
//  HaircisionIntroViewController.swift
//  Haircision
//
//  Created by Brian Canela on 6/1/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit

class HaircisionIntroViewController: UIViewController {

 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }


}
