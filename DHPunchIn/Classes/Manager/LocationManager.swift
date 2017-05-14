//
//  LocationManager.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 11/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private static var _manager: LocationManager?
    
    private var locationStatus: String?
    private var manager: CLLocationManager!
    public var currentCoordinate: CLLocationCoordinate2D?
    public dynamic var updateCount = 0
    
    public static func sharedInstance() -> LocationManager {
        if _manager == nil {
            _manager = LocationManager()
        }
        return _manager!
    }
    
    func startLocation() {
        manager.delegate = self

        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func stopLocation() {
        manager.stopUpdatingLocation()
    }
    
    override init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5
    }
    
    // MARK: - CLLocationManagerDelegate Methods
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        manager.stopUpdatingLocation()
        if (error != nil) {
            print("\(error)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        currentCoordinate = locationObj.coordinate
        updateCount += 1
        
        print("\(updateCount) \((currentCoordinate?.latitude)!) , \((currentCoordinate?.longitude)!)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
        }
        
        print(locationStatus!)
    }
}
