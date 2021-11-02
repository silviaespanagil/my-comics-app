//
//  ServerImageResponseUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics

class ServerImageResponseUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testImageConvertToEntity() {
        
        // Given
        let serverImageResponse = ServerImageResponse(smallUrl: "smallUrl",
                                                      superUrl: "superUrl",
                                                      thumbUrl: "thumbUrl")
        
        // When
        let image = serverImageResponse.converToEntity()
        
        // Then
        XCTAssertEqual(image.smallUrl, serverImageResponse.smallUrl)
        XCTAssertEqual(image.superUrl, serverImageResponse.superUrl)
        XCTAssertEqual(image.thumbUrl, serverImageResponse.thumbUrl)
    }
}

