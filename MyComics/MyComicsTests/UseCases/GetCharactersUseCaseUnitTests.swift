//
//  GetCharactersUseCaseUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics

class GetCharactersUseCaseUnitTests: XCTestCase {

    var sut: GetCharactersUseCase?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testGetCharactersIsCalled(){
        
        //GIVEN
        let repository = MockCharacterRepository()
        sut = GetCharactersUseCase(repository: repository)
        
        //WHEN
        _ = sut!.execute()
        
        //THEN
        XCTAssertTrue(repository.isGetCharactersCalled)
    }
}
