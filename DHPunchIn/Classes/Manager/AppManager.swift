//
//  AppManager.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 08/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

let USER_KEY: String = "USER_KEY"

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
