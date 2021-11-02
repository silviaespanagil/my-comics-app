//
//  ServerCharacterResponseUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 18/10/21.
//

import XCTest
@testable import MyComics

class ServerCharaterResponseUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testConvertToEntity() {
        
        // Given
        let serverCharacterResponse = ServerCharacterResponse(id: 0,
                                                              name: "name",
                                                              realName: "realName",
                                                              aliases: "aliases",
                                                              image: nil,
                                                              birth: nil,
                                                              deck: nil,
                                                              gender: nil,
                                                              origin: nil,
                                                              powers: [])
        
        // When
        let character = serverCharacterResponse.converToEntity()
        
        // Then
        XCTAssertEqual(character.id, serverCharacterResponse.id)
        XCTAssertEqual(character.name, serverCharacterResponse.name)
        XCTAssertEqual(character.realName, serverCharacterResponse.realName)
        XCTAssertEqual(character.aliases, serverCharacterResponse.aliases)
    }
}
