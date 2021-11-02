//
//  ServerPowerResponseUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics


class ServerPowerResponseUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        try super.tearDownWithError()
    }
    
    func testPowerConvertToEntity() {
        
        // Given
        let serverPowerResponse = ServerPowerResponse(id: 1,
                                                      name: "name")
        
        // When
        let power = serverPowerResponse.convertToEntity()
        
        // Then
        XCTAssertEqual(power.id, serverPowerResponse.id)
        XCTAssertEqual(power.name, serverPowerResponse.name)

    }
}

