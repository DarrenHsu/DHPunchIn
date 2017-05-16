//
//  TimePickerViewController.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 16/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {
    
    @IBOutlet var picker: UIDatePicker?
    @IBOutlet var cancelButton: UIButton?
    @IBOutlet var doneButton: UIButton?
    @IBOutlet var titleLabel: UILabel?
    
    var cancelPress: ((_ : TimePickerViewController) -> Void)?
    var doneProcess: ((_ : TimePickerViewController, _ : Date) -> Void)?
    
    @IBAction func donePressed(button: UIButton) {
        doneProcess?(self, (picker?.date)!)
        
        dismiss()
    }
    
    @IBAction func cancelPressed(button: UIButton) {
        cancelPress?(self)
        
        dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.borderColor = UIColor.lightGray.cgColor
        self.view.layer.borderWidth = 1
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
        
        cancelButton?.layer.borderColor = UIColor.lightGray.cgColor
        cancelButton?.layer.borderWidth = 1
        cancelButton?.layer.cornerRadius = 10
        cancelButton?.layer.masksToBounds = true
        
        doneButton?.layer.borderColor = UIColor.lightGray.cgColor
        doneButton?.layer.borderWidth = 1
        doneButton?.layer.cornerRadius = 10
        doneButton?.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.superview?.alpha = 0
        }, completion: { (completed) in
            self.view.superview?.removeFromSuperview()
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }
    
    static func pop(_ parent: UIViewController, view: UIView, title: String?, timeStr: String?) -> TimePickerViewController {
        let rect = view.superview?.convert(view.frame, to: parent.view)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "TimePickerViewController") as! TimePickerViewController
        controller.view.center = parent.view.center
        controller.view.frame = CGRect(x: controller.view.frame.origin.x , y: (rect?.origin.y)! + (rect?.size.height)!, width: controller.view.frame.size.width, height: controller.view.frame.size.height)
        controller.titleLabel?.text = title
        
        parent.addChildViewController(controller)
        
        let view = UIView(frame: parent.view.bounds)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.alpha = 0
        view.addSubview(controller.view)
        
        parent.view.addSubview(view)
        
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 1
        }, completion: {(complete) in
            
            if timeStr != nil && timeStr != "" {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let time = dateFormatter.date(from: timeStr!)
                controller.picker?.date = time!
            }
            
        })
        
        return controller;
    }
}
