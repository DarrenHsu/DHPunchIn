//
//  DHPunchInTests.swift
//  DHPunchInTests
//
//  Created by Darren Hsu on 08/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import XCTest
@testable import DHPunchIn

class DHPunchInTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddStaff() {
        let expectation = self.expectation(description: "Test Add Staff")
        
        let feed = FeedManager.sharedInstance()
        
        let staff = Staff()
        staff.staffId = "505400101"
        staff.name = "許仲恩"
        staff.seatArea = "A01"
        staff.startTime = "08:30:00"
        staff.endTime = "17:30:00"
        
        feed.requestAddStaff(staff, success: { (staffs) in
            XCTAssertNotNil(staffs, ">> Added staff is faild")
            XCTAssert((staffs?.count)! > 0, ">> the count of staffs is zero")
            expectation.fulfill()
        }) {
            XCTAssert(false, ">> testAddStaff had error!")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            if error != nil {
                print("Error: \(error!))")
            }
        }
    }
}
