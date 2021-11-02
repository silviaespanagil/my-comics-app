//
//  DBPowerUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics

class DBPowerUnitTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }
    
    func testConvertDBPowerToEntity() {
        
        let id: Int = 1
        let dbPowerResponse = DBPower(context: TestCoreDataStack().managedContext)
        dbPowerResponse.id = Int32(id)
        dbPowerResponse.name = "name"
        
        let power = dbPowerResponse.convertToEntity()
        
        XCTAssertNotNil(power)
        XCTAssertEqual(Int32(power.id), dbPowerResponse.id)
        XCTAssertEqual(power.name, dbPowerResponse.name)
    }
}
