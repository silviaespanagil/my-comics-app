//
//  DBImageUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics


class DBImageUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        try super.tearDownWithError()
    }
    
    func testConvertDBImageToEntity() {
        
        let dbImageResponse = DBImage(context: TestCoreDataStack().managedContext)
        dbImageResponse.smallUrl = "smallURL"
        dbImageResponse.superUrl = "superUrl"
        dbImageResponse.thumbUrl = "thumbUrl"
        
        let image = dbImageResponse.convertToEntity()
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image.smallUrl, dbImageResponse.smallUrl)
        XCTAssertEqual(image.superUrl, dbImageResponse.superUrl)
        XCTAssertEqual(image.thumbUrl, dbImageResponse.thumbUrl)
    }
}
