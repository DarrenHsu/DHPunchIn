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
    private let defaultCoordinate = CLLocationCoordinate2D(latitude: 25.0530796100264, longitude: 121.56007485006)
    
    public static func sharedInstance() -> LocationManager {
        if _manager == nil {
            _manager = LocationManager()
        }
        return _manager!
    }
    
    override init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5
    }
    
    public func startLocation() {
        manager.delegate = self
        
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    public func stopLocation() {
        manager.stopUpdatingLocation()
    }
    
    public func calculateDistance() ->  CLLocationDistance {
        if currentCoordinate == nil {
            return 999
        }
        
        return calculateDistance(defaultCoordinate.latitude, lonA: defaultCoordinate.longitude, latB: (currentCoordinate?.latitude)!, lonB: (currentCoordinate?.longitude)!)
    }
    
    private func calculateDistance(_ latA: CLLocationDegrees, lonA: CLLocationDegrees, latB: CLLocationDegrees, lonB: CLLocationDegrees) -> CLLocationDistance {
        let locationA = CLLocation(latitude: latA, longitude: lonA)
        let locationB = CLLocation(latitude: latB, longitude: lonB)
        return locationA.distance(from: locationB)
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
