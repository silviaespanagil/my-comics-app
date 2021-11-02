//
//  RemoveCharacterUseCaseUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics

class RemoveCharacterUseCaseUnitTests: XCTestCase {

    var sut: RemoveCharacterUseCase?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testRemoveCharacterIsCalled(){
        
        //GIVEN
        let repository = MockCharacterRepository()
        sut = RemoveCharacterUseCase(repository: repository)
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
        
        //WHEN
      sut!.execute(character : character)
        
        //THEN
        XCTAssertTrue(repository.isRemoveCharacterCalled)
    }
}
