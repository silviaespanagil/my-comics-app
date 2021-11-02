//
//  SearchUseCaseUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 18/10/21.
//

import XCTest
@testable import MyComics

class SearchUseCaseUnitTests: XCTestCase {

    var sut: SearchCharacterUseCase?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testSearchCalled() {
        
        // Given
        let repository = MockSearchRepository()
        sut = SearchCharacterUseCase(repository: repository)
        
        // When
        _ = sut!.execute(searchTerm: "batman")
        
        // Then
        XCTAssertTrue(repository.isSearchCalled)
    }
}
