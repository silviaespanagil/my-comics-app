//
//  DBManagerUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 26/10/21.
//

import XCTest
@testable import MyComics

class DBManagerUnitTests: XCTestCase {

    var sut: DBManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        sut = DBManager(coreDataStack: TestCoreDataStack())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testSaveCharacter() {
        
        // Given
        let character = Character(id: 1,
                                  name: "name",
                                  realName: "real_name",
                                  aliases: "aliases",
                                  image: nil,
                                  birth: "birth",
                                  deck: "deck",
                                  gender: .other,
                                  origin: "origin",
                                  powers: [])
        
        // When
        sut.saveCharacter(character: character)
        let response = sut.getCharacters()
        
        // Then
        XCTAssertEqual(response.count, 1)
    }
    
    func testRemoveCharacter() {
        
        // Given
        let character = Character(id: 1,
                                  name: "name",
                                  realName: "real_name",
                                  aliases: "aliases",
                                  image: nil,
                                  birth: "birth",
                                  deck: "deck",
                                  gender: .other,
                                  origin: "origin",
                                  powers: [])
        
        // When
        sut.saveCharacter(character: character)
        sut.removeCharacter(character: character)
        let response = sut.getCharacters()
        
        // Then
        XCTAssertEqual(response.count, 0)
    }
    
    func testGetCharacter() {
        
        // Given
        let character = Character(id: 1,
                                  name: "name",
                                  realName: "real_name",
                                  aliases: "aliases",
                                  image: nil,
                                  birth: "birth",
                                  deck: "deck",
                                  gender: .other,
                                  origin: "origin",
                                  powers: [])
        
        // When
        sut.saveCharacter(character: character)
        let response = sut.getCharacters()
        
        // Then
        XCTAssertEqual(response.count, 1)
        XCTAssertEqual(response.first?.id, character.id)
        XCTAssertEqual(response.first?.name, character.name)
        XCTAssertEqual(response.first?.realName, character.realName)
        XCTAssertEqual(response.first?.aliases, character.aliases)
        XCTAssertEqual(response.first?.birth, character.birth)
        XCTAssertEqual(response.first?.deck, character.deck)
        XCTAssertEqual(response.first?.gender, character.gender)
        XCTAssertEqual(response.first?.origin, character.origin)
    }
    
    func testExistCharacterTrue() {
        
        // Given
        let character = Character(id: 1,
                                  name: "name",
                                  realName: "real_name",
                                  aliases: "aliases",
                                  image: nil,
                                  birth: "birth",
                                  deck: "deck",
                                  gender: .other,
                                  origin: "origin",
                                  powers: [])
        
        // When
        sut.saveCharacter(character: character)
        let response = sut.existCharacter(character: character)
        
        // Then
        XCTAssertTrue(response)
    }
    
    func testExistCharacterFalse() {
        
        // Given
        let character = Character(id: 1,
                                  name: "name",
                                  realName: "real_name",
                                  aliases: "aliases",
                                  image: nil,
                                  birth: "birth",
                                  deck: "deck",
                                  gender: .other,
                                  origin: "origin",
                                  powers: [])
        
        // When
        let response = sut.existCharacter(character: character)
        
        // Then
        XCTAssertFalse(response)
    }
    
    func testGetCharacterId() {
        
        // Given
        let character = Character(id: 1,
                                  name: "name",
                                  realName: "real_name",
                                  aliases: "aliases",
                                  image: nil,
                                  birth: "birth",
                                  deck: "deck",
                                  gender: .other,
                                  origin: "origin",
                                  powers: [])
        
        // When
        sut.saveCharacter(character: character)
        let response = sut.getCharacter(id: 1)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.id, character.id)
        XCTAssertEqual(response?.name, character.name)
        XCTAssertEqual(response?.realName, character.realName)
        XCTAssertEqual(response?.aliases, character.aliases)
        XCTAssertEqual(response?.birth, character.birth)
        XCTAssertEqual(response?.deck, character.deck)
        XCTAssertEqual(response?.gender, character.gender)
        XCTAssertEqual(response?.origin, character.origin)
    }
}
