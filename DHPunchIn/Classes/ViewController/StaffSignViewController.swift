//
//  StaffSignViewController.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 11/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class StaffSignViewController: BaseViewController {
    
    @IBOutlet var baseView: UIView?
    @IBOutlet var resteButton: UIButton?
    @IBOutlet var submitButton: UIButton?
    @IBOutlet var fields: [UITextField]?
    @IBOutlet var noField: UITextField?
    @IBOutlet var nameField: UITextField?
    @IBOutlet var areaField: UITextField?
    @IBOutlet var startField: UITextField?
    @IBOutlet var endField: UITextField?
    
    @IBAction func restPressed(button: UIButton) {
        for field in fields! {
            field.text = nil
        }
    }
    
    @IBAction func submitPressed(button: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        baseView?.layer.borderColor = UIColor.lightGray.cgColor
        baseView?.layer.borderWidth = 1
        baseView?.layer.cornerRadius = 10
        baseView?.layer.masksToBounds = true
        
        resteButton?.layer.borderColor = UIColor.lightGray.cgColor
        resteButton?.layer.borderWidth = 1
        resteButton?.layer.cornerRadius = 10
        resteButton?.layer.masksToBounds = true
        
        submitButton?.layer.borderColor = UIColor.lightGray.cgColor
        submitButton?.layer.borderWidth = 1
        submitButton?.layer.cornerRadius = 10
        submitButton?.layer.masksToBounds = true
        
        for field in fields! {
            field.layer.borderColor = UIColor.lightGray.cgColor
            field.layer.borderWidth = 1
            field.layer.cornerRadius = 5
            field.layer.masksToBounds = true
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.addGestureRecognizer(gesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapGesture() {
        self.view.endEditing(false)
    }
    
}
