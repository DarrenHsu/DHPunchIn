//
//  Staff.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 08/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class Staff: NSObject {
    
    var staffId: String?
    var name: String?
    var seatArea: String?
    var startTime: String?
    var endTime: String?
    var photoURL: String?
    
    static func conver(dict: [String: Any]) -> Staff {
        let staff = Staff()
        staff.setValuesForKeys(dict)
        
        return staff
    }
}
