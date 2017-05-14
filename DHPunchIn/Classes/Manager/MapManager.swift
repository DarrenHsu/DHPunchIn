//
//  MapManager.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 14/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit
import GoogleMaps

class MapManager: NSObject {

    private static var _manager: MapManager?
    
    public static func sharedInstance() -> MapManager {
        if _manager == nil {
            _manager = MapManager()
            GMSServices.provideAPIKey("AIzaSyBRA9y8POa8I4-NLr21c9dCi3phh5PVGLE")
        }
        return _manager!
    }
    
    public func draw(_ map: GMSMapView, icon: UIImage?, title: String?, snippet: String?, coordinate: CLLocationCoordinate2D) -> GMSMarker {
        let marker = GMSMarker(position: coordinate)
        marker.icon = icon
        marker.title = title
        marker.snippet = snippet
        marker.map = map
        map.camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15)
        
        if icon != nil {
            marker.groundAnchor = CGPoint(x: 0.5, y: 1.3)
        }
        
        return marker
    }
    
    public func moveMarker(_ marker: GMSMarker?, coordinate: CLLocationCoordinate2D?) {
        marker?.position = coordinate!
    }
    
    
}
