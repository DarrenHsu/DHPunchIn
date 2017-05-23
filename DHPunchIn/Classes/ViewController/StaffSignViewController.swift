//
//  StaffSignViewController.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 11/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class StaffSignViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet var views: [UIView]?
    @IBOutlet var gettingView: UIView?
    @IBOutlet var signingView: UIView?

    @IBOutlet var buttons: [UIButton]?
    @IBOutlet var uploadButton: UIButton?
    @IBOutlet var addButton: UIButton?
    @IBOutlet var resetButton: UIButton?
    @IBOutlet var staffButton: UIButton?
    
    @IBOutlet var fields: [UITextField]?
    @IBOutlet var noField: UITextField?
    @IBOutlet var hasNoField: UITextField?
    @IBOutlet var nameField: UITextField?
    @IBOutlet var areaField: UITextField?
    @IBOutlet var startLabel: UILabel?
    @IBOutlet var startField: UITextField?
    @IBOutlet var endLabel: UILabel?
    @IBOutlet var endField: UITextField?

    @IBOutlet var actionItem: UIBarButtonItem?
    
    @IBAction func goStaffPressed(button: UIButton) {
        gettingView?.isHidden = true
        signingView?.isHidden = false
        self.loadDefaultValue(true)
    }
    
    @IBAction func goGettingPressed(button: UIButton) {
        gettingView?.isHidden = false
        signingView?.isHidden = true
        self.loadDefaultValue(true)
    }
    
    @IBAction func goSigningPressed(button: UIButton) {
        if app.staff != nil {
            ui.showAlert("是否要切換員工?", controller: self, submit: {
                self.app.staff = nil
                self.gettingView?.isHidden = true
                self.signingView?.isHidden = false
                self.loadDefaultValue(true)
            }, cancel: nil)
        }else {
            self.gettingView?.isHidden = true
            self.signingView?.isHidden = false
            self.loadDefaultValue(true)
        }
        
    }
    
    @IBAction func getPressed(button: UIButton) {
        guard !(hasNoField?.text?.isEmpty)! else {
            ui.showAlert("請輸入員編", controller: self)
            return
        }
        
        ui.startLoading(self.view)
        feed.requestStaff((hasNoField?.text)!, success: { (staff) in
            self.app.saveStaff(staff)
            self.loadDefaultValue(false)
            self.ui.stopLoading()
        }) {
            self.ui.stopLoading()
            self.ui.showAlert("查無此員工資料", controller: self)
        }
    }
    
    @IBAction func restPressed(button: UIButton) {
        noField?.text = app.staff != nil ? app.staff?.staffId : nil
        nameField?.text = app.staff != nil ? app.staff?.name : nil
        areaField?.text = app.staff != nil ? app.staff?.seatArea : nil
        startField?.text = app.staff != nil ? app.staff?.startTime : nil
        endField?.text = app.staff != nil ? app.staff?.endTime : nil
    }
    
    @IBAction func addPressed(button: UIButton) {
        let staff = createStaff()
        guard staff.checkStaffData() else {
            ui.showAlert("請輸入完整資料。", controller: self)
            return
        }
        
        ui.startLoading(self.view)
        feed.requestAddStaff(staff, success: { (staff) in
            self.app.saveStaff(staff)
            self.loadDefaultValue(false)
            self.ui.stopLoading()
        }) {
            self.ui.stopLoading()
            self.ui.showAlert("新增員工失敗", controller: self)
        }
    }
    
    @IBAction func updatePressed(button: UIButton) {
        let staff = createStaff()
        guard staff.checkStaffData() else {
            ui.showAlert("請輸入完整資料。", controller: self)
            return
        }
        
        ui.startLoading(self.view)
        feed.requestUploadStaff(staff, success: { (staffs) in
            self.app.saveStaff((staffs?.first)!)
            self.loadDefaultValue(false)
            self.ui.stopLoading()
        }) {
            self.ui.stopLoading()
            self.ui.showAlert("修改員工失敗", controller: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for view in views! {
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
        
        for button in buttons! {
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
        }
        
        for field in fields! {
            field.layer.borderColor = UIColor.lightGray.cgColor
            field.layer.borderWidth = 1
            field.layer.cornerRadius = 5
            field.layer.masksToBounds = true
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.addGestureRecognizer(gesture)
        
        loadDefaultValue(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDefaultValue(_ forceShow: Bool) {
        if !forceShow {
            self.gettingView?.isHidden = self.app.staff != nil
            self.signingView?.isHidden = self.app.staff == nil
        }
        
        if app.staff != nil {
            noField?.text = app.staff?.staffId
            noField?.alpha = 0.5
            
            nameField?.text = app.staff?.name
            areaField?.text = app.staff?.seatArea
            startField?.text = app.staff?.startTime
            endField?.text = app.staff?.endTime
        }else {
            noField?.text = nil
            noField?.alpha = 1
            
            nameField?.text = nil
            areaField?.text = nil
            startField?.text = nil
            endField?.text = nil
        }
        
        staffButton?.isHidden = app.staff == nil
        noField?.isEnabled = app.staff == nil
        uploadButton?.isHidden = app.staff == nil
        addButton?.isHidden = app.staff != nil
    }
    
    func tapGesture() {
        self.view.endEditing(false)
    }
    
    func createStaff() -> Staff {
        let staff = Staff()
        staff.staffId = noField?.text
        staff.name = nameField?.text
        staff.seatArea = areaField?.text
        staff.startTime = startField?.text
        staff.endTime = endField?.text
        return staff
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
