//
//  BarbershopSelectedViewController.swift
//  Haircision
//
//  Created by Brian Canela on 6/4/18.
//  Copyright © 2018 Brian Canela. All rights reserved.
//

import UIKit

class BarbershopSelectedViewController: UIViewController {
    
    var selection: String!
    
    var selectedBarbershop : BarbershopModel?
    
    @IBOutlet private weak var detailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        detailLabel.text = selection
        
    }

    override func viewWillAppear(_ animated: Bool) {
        title = selection
    }
    
    
    
    

}
