//
//  CharacterUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics

// TODO : No estoy segura si testGetPowerIsCalled() tiene sentido xD

class CharacterUnitTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        try super.tearDownWithError()
    }
    
    func testGetGenderIsCalled() {
        
        // Given
        let character = Character(id: 1,
                                  name: "name",
                                  realName: "realName",
                                  aliases: "aliases",
                                  image: nil,
                                  birth: "birth",
                                  deck: "deck",
                                  gender: Gender(rawValue: 1) ?? .other,
                                  origin: "origin",
                                  powers: [])
        
        //When
        let gender = character.getGender()
        
        //Then
        XCTAssertNotNil(gender)
        XCTAssertEqual(gender.description, character.gender.description)
    }
    
    func testGetPowerIsCalled() {
        
        // Given
        var powerArray: [Power] = []
        
        let power1 = Power(id: 1, name: "Fly")
        let power2 = Power(id: 2, name: "Telekinesis")
        
        powerArray.append(power1)
        powerArray.append(power2)
        
        let character = Character(id: 1,
                                  name: "name",
                                  realName: "realName",
                                  aliases: "aliases",
                                  image: nil,
                                  birth: "birth",
                                  deck: "deck",
                                  gender: Gender(rawValue: 1) ?? .other,
                                  origin: "origin",
                                  powers: powerArray)
        
        // When
        let power = character.getPowers()
        
        // Then
        XCTAssertNotNil(power)
        XCTAssertEqual(power, "Fly, Telekinesis")
    }
}


