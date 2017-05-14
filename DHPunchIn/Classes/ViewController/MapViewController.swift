//
//  MapViewController.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 11/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {
    
    @IBOutlet var mapView: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewRegion = MKCoordinateRegionMakeWithDistance(location.currentCoordinate!, 500, 500);
        let adjustedRegion = mapView?.regionThatFits(viewRegion)
        mapView?.setRegion(adjustedRegion!, animated: true)
        mapView?.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
