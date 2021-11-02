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

        let character = Character(id: 1, name: "name", realName: "realName", aliases: "aliases", image: nil, birth: "birth", deck: "deck", gender: Gender(rawValue: 1)!, origin: "origin", powers: [])
    
        let gender = character.getGender()
        
        XCTAssertNotNil(gender)
        XCTAssertEqual(gender.description, character.gender.description)
        }
    
    func testGetPowerIsCalled() {

        let powerArray = [Power].self()
        
        let character = Character(id: 1, name: "name", realName: "realName", aliases: "aliases", image: nil, birth: "birth", deck: "deck", gender: Gender(rawValue: 1)!, origin: "origin", powers: powerArray)
    
        let power = character.getPowers()
        
        XCTAssertNotNil(power)
        }
    }
    

