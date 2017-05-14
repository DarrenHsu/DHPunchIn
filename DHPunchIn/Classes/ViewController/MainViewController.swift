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
    
    @IBOutlet var mapBaseView: UIView?
    
    var mapManager = MapManager.sharedInstance()
    var mapView: GMSMapView!
    var marker: GMSMarker?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "現在位置"
        
        mapView = GMSMapView(frame: (mapBaseView?.bounds)!)
        mapView.isMyLocationEnabled = true
        mapView.accessibilityElementsHidden = true
        mapView.delegate = self
        
        mapBaseView?.addSubview(mapView)
        
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
        }
    }
    
    func addMark() {
        if marker == nil {
            marker = mapManager.draw(mapView, icon: nil, title: "Staff", snippet: nil, coordinate: self.location.currentCoordinate!)
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
