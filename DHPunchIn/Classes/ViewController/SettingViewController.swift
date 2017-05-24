//
//  SettingViewController.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 24/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    
    @IBOutlet var views: [UIView]!
    @IBOutlet var baseView: UIView!
    @IBOutlet var latField: UITextField!
    @IBOutlet var lonField: UITextField!
    @IBOutlet var dnsTextView: UITextView!

    @IBAction func updatePressed(button: UIButton) {
        app.saveDns(dnsTextView.text)
        app.saveLat(Double(latField.text!)!)
        app.saveLon(Double(lonField.text!)!)
        
        feed.resetDns()
        location.resetCoordinate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in views! {
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
        
        latField.text = String(format: "%f", location.defaultCoordinate.latitude)
        lonField.text = String(format: "%f", location.defaultCoordinate.longitude)
        dnsTextView.text = String(format: "%@", feed.Dns)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
