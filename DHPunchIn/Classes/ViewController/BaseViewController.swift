//
//  BaseViewController.swift
//  iEnglish
//
//  Created by Dareen Hsu on 12/21/15.
//  Copyright © 2015 D.H. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, SlideNavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- SlideNavigationControllerDelegate Methods
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }

    func slideNavigationControllerShouldDisplayRightMenu() -> Bool {
        return false
    }

    func showAlert(_ message : String?) {
        let alert : UIAlertController = UIAlertController.init(title: "Action", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let callaction = UIAlertAction(title: "ok",style: .default, handler: nil);

        alert.addAction(callaction)
        present(alert, animated: true, completion: nil)
    }

}
