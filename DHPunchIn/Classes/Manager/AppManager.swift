//
//  AppManager.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 08/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

let USER_KEY: String = "USER_KEY"
let DNS_KEY: String = "DNS_KEY"
let LAT_KEY: String = "LAT_KEY"
let LON_KEY: String = "LON_KEY"

class AppManager: NSObject {
    
    private static var _manager: AppManager?
    public var staff: Staff?
    
    public static func sharedInstance() -> AppManager {
        if _manager == nil {
            _manager = AppManager()
            _manager?.staff = _manager?.getStaff()
        }
        return _manager!
    }
    
    public func saveDns(_ dns: String) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(dns, forKey: DNS_KEY)
    }
    
    public func saveLat(_ lat: Double) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(lat, forKey: LAT_KEY)
    }
    
    public func saveLon(_ lon: Double) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(lon, forKey: LON_KEY)
    }
    
    public func saveStaff(_ staff: Staff) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: staff)
        let userDefault = UserDefaults.standard
        userDefault.setValue(encodedData, forKey: USER_KEY)
        
        self.staff = staff
    }
    
    public func removeStaff() {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: USER_KEY)
        
        self.staff = nil
    }
    
    public func getStaff() -> Staff? {
        let userDefault = UserDefaults.standard
        let data = userDefault.value(forKey: USER_KEY)
        if data == nil {
            return nil
        }
        
        let staff = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Staff
        return staff
    }

}
