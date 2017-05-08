//
//  AppManager.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 08/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class AppManager: NSObject {
    
    private static var _manager: AppManager?
    
    public static func sharedInstance() -> AppManager {
        if _manager == nil {
            _manager = AppManager()
        }
        return _manager!
    }

}
