//
//  PunchInViewController.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 11/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class PunchInViewController: BaseViewController {

    @IBOutlet var latLabel: UILabel?
    @IBOutlet var longLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if location.currentCoordinate != nil {
            latLabel?.text = String(format: "%f",(location.currentCoordinate?.latitude)!)
            longLabel?.text = String(format: "%f",(location.currentCoordinate?.longitude)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
