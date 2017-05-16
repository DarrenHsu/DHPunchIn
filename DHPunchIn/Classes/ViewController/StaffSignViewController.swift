//
//  StaffSignViewController.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 11/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class StaffSignViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet var baseView: UIView?
    @IBOutlet var resteButton: UIButton?
    @IBOutlet var submitButton: UIButton?
    @IBOutlet var fields: [UITextField]?
    @IBOutlet var noField: UITextField?
    @IBOutlet var nameField: UITextField?
    @IBOutlet var areaField: UITextField?
    @IBOutlet var startLabel: UILabel?
    @IBOutlet var startField: UITextField?
    @IBOutlet var endLabel: UILabel?
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
    
    func showDatePicker(_ field: UITextField, title: String?) {
        let controller = TimePickerViewController.pop(self, view: field, title: title, timeStr: field.text)
        
        controller.doneProcess = {(_controller, _date) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            field.text = dateFormatter.string(from: _date)
        }
    }
    
    //MARK: - UITextFieldDelegate Methods
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == startField {
            self.showDatePicker(textField, title: startLabel?.text)
            return false
        }else if textField == endField {
            self.showDatePicker(textField, title: endLabel?.text)
            return false
        }
        return true
    }
    
    
}
