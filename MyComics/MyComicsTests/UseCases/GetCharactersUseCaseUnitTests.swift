//
//  GetCharactersUseCaseUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//
import Resolver
import XCTest
@testable import MyComics

class GetCharactersUseCaseUnitTests: XCTestCase {

    @LazyInjected var repository: MockCharacterRepository
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
        sut = GetCharactersUseCase()
        
        //WHEN
        _ = sut!.execute()
        
        //THEN
        XCTAssertTrue(repository.isGetCharactersCalled)
    }
}
