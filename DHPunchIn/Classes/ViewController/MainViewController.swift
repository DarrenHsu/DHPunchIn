//
//  MainViewController.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 08/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit
import GoogleMaps

class MainViewController: BaseViewController, GMSMapViewDelegate {
    
    @IBOutlet var baseView: UIView?
    @IBOutlet var mapBaseView: UIView?
    @IBOutlet var staffBaseView: UIView?
    @IBOutlet var punchCardButton: UIButton?
    @IBOutlet var noLable: UILabel?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var distancLabel: UILabel?
    
    var mapManager = MapManager.sharedInstance()
    var mapView: GMSMapView!
    var marker: GMSMarker?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "現在位置"
        
        baseView?.layer.borderColor = UIColor.lightGray.cgColor
        baseView?.layer.borderWidth = 1
        baseView?.layer.cornerRadius = 10
        baseView?.layer.masksToBounds = true
        
        staffBaseView?.layer.borderColor = UIColor.lightGray.cgColor
        staffBaseView?.layer.borderWidth = 1
        staffBaseView?.layer.cornerRadius = 10
        staffBaseView?.layer.masksToBounds = true
        
        punchCardButton?.layer.borderColor = UIColor.lightGray.cgColor
        punchCardButton?.layer.borderWidth = 1
        punchCardButton?.layer.cornerRadius = 10
        punchCardButton?.layer.masksToBounds = true
        
        mapView = GMSMapView(frame: (mapBaseView?.bounds)!)
        mapView.isMyLocationEnabled = true
        mapView.accessibilityElementsHidden = true
        mapView.delegate = self
        
        mapBaseView?.addSubview(mapView)
        
        self.loadDefaultVlue()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        location.addObserver(self, forKeyPath:"updateCount", options:.new, context: nil)
        
        mapView.frame = (mapBaseView?.bounds)!
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
            mapManager.moveMarker(marker, coordinate: location.currentCoordinate)
            distancLabel?.text = String(format: "距離： %f", location.calculateDistance())
        }
    }
    
    func loadDefaultVlue() {
        if app.staff != nil {
            ui.startLoading(self.view)
            feed.requestStaff((app.staff?.staffId)!, success: { (staff) in
                self.app.saveStaff(staff)
                self.noLable?.text = self.app.staff?.staffId
                self.nameLabel?.text = self.app.staff?.name
                self.ui.stopLoading()
            }, failure: {
                self.app.removeStaff()
                self.ui.stopLoading()
            })
        }
    }
    
    func addMark() {
        let icon = UIImage(named: "ic_staff")?.resizeImage(newWidth: 50)
        if marker == nil && self.location.currentCoordinate != nil {
            marker = mapManager.draw(mapView, icon: icon, title: "Staff", snippet: nil, coordinate: self.location.currentCoordinate!)
        }
    }
    
    //MARK: - GMSMapViewDelegate Methods
    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.addMark()
    }
    
    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.addMark()
    }

}
