//
//  PunchInViewController.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 11/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class PunchInViewController: BaseViewController {

    @IBOutlet var positionView: UIView?
    @IBOutlet var latLabel: UILabel?
    @IBOutlet var longLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionView?.layer.borderColor = UIColor.lightGray.cgColor
        positionView?.layer.borderWidth = 1
        positionView?.layer.cornerRadius = 10
        positionView?.layer.masksToBounds = true
        
        loadCoordinate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        location.addObserver(self, forKeyPath:"updateCount", options:.new, context: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        location.removeObserver(self, forKeyPath: "updateCount")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "updateCount" {
            loadCoordinate()
        }
    }
    
    func loadCoordinate() {
        if location.currentCoordinate != nil {
            latLabel?.text = String(format: "%f",(location.currentCoordinate?.latitude)!)
            longLabel?.text = String(format: "%f",(location.currentCoordinate?.longitude)!)
        }
    }

}
