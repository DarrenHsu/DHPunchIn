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
    @IBOutlet var distanceLabel: UILabel?
    @IBOutlet var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionView?.layer.borderColor = UIColor.lightGray.cgColor
        positionView?.layer.borderWidth = 1
        positionView?.layer.cornerRadius = 10
        positionView?.layer.masksToBounds = true
        
        loadCoordinate()
        loadImage()
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
            distanceLabel?.text = String(format: "%zd 公尺", Int(location.calculateDistance()))
        }
    }

    func loadImage () {
        guard location.calculateDistance() < 10 else {
            ui.showAlert("你目前不在指定區域內!", controller: self)
            return
        }
        
        guard app.staff != nil else {
            return
        }
        
        ui.startLoading(self.view)
        feed.requestImage((app.staff?.imageUrl)!, success: { (image) in
            self.imageView?.image = image
            self.ui.stopLoading()
        }) {(msg) in
            self.ui.stopLoading()
            self.ui.showAlert(msg, controller: self)
        }
    }
}
