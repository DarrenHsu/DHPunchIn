//
//  Staff.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 08/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

class Staff: NSObject, NSCoding  {
    
    var staffId: String?
    var name: String?
    var seatArea: String?
    var startTime: String?
    var endTime: String?
    var imageUrl: String?
    var targetId: String?
    
    required override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        staffId = aDecoder.decodeObject(forKey: "staffId") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        seatArea = aDecoder.decodeObject(forKey: "seatArea") as? String
        startTime = aDecoder.decodeObject(forKey: "startTime") as? String
        endTime = aDecoder.decodeObject(forKey: "endTime") as? String
        imageUrl = aDecoder.decodeObject(forKey: "imageUrl") as? String
        targetId = aDecoder.decodeObject(forKey: "targetId") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(staffId, forKey: "staffId")
        aCoder.encode(seatArea, forKey: "seatArea")
        aCoder.encode(startTime, forKey: "startTime")
        aCoder.encode(endTime, forKey: "endTime")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(imageUrl, forKey: "imageUrl")
        aCoder.encode(targetId, forKey: "targetId")
    }
    
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }

    static func parse(x: Any?) -> [Staff] {
        var staffs: [Staff] = []
        if let dicts = x as? [Dictionary<String, Any>] {
            for dict in dicts {
                staffs.append(conver(dict: dict))
            }
        }
        
        if let dict = x as? Dictionary<String, Any> {
            staffs.append(conver(dict: dict))
        }
        return staffs
    }
    
    static func conver(dict: [String: Any]) -> Staff {
        let staff = Staff()
        staff.setValuesForKeys(dict)
        
        return staff
    }
    
    func checkStaffData() -> Bool {
        guard staffId != nil && staffId != "" else {
            return false
        }
        
        guard name != nil && name != "" else {
            return false
        }
        
        guard seatArea != nil && seatArea != "" else {
            return false
        }
        
        guard startTime != nil && startTime != "" else {
            return false
        }
        
        guard endTime != nil && endTime != "" else {
            return false
        }
        
        return true
    }
}
