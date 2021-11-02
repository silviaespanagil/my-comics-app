//
//  DBCharacterUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics

class DBCharacterUnitTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        try super.tearDownWithError()
    }
    
    func testDBCharacterConvertToEntity(){
        
        // Give
        let id: Int = 1
        let dataBaseCharacter = DBCharacter(context: TestCoreDataStack().managedContext)
        
        dataBaseCharacter.id = Int32(id)
        dataBaseCharacter.name = "name"
        dataBaseCharacter.realName = "realName"
        
        // When
        let character = dataBaseCharacter.convertToEntity()
       
        XCTAssertNotNil(character)
        XCTAssertEqual(dataBaseCharacter.name, character.name)
        XCTAssertEqual(dataBaseCharacter.realName, character.realName)
    }
}

