//
//  SwiftUIDemoTests.swift
//  SwiftUIDemoTests
//
//  Created by Nguyen Dinh Duong on 2020/10/17.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import XCTest

class SwiftUIDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // add test
        let ndFamily = NDFamily(name: "DuongND", age: 27)
        
        XCTAssertEqual(ndFamily.name, "DuongND")
        XCTAssertEqual(ndFamily.age, 27)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

struct NDFamily {
    var name: String?
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
