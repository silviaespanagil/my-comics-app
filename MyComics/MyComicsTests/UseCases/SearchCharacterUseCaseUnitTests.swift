//
//  SearchUseCaseUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 18/10/21.
//
import Resolver
import XCTest
@testable import MyComics

class SearchUseCaseUnitTests: XCTestCase {

    // MARK: - Properties
    @LazyInjected var mockSearchRepository: MockSearchRepository
    var sut: SearchCharacterUseCase?
    
    // MARK: - Life Cycle
      override func setUp() {
          super.setUp()

          sut = SearchCharacterUseCase()
          Resolver.registerMockServices()
      }

      override func tearDown() {
          sut = nil

          super.tearDown()
      }
    
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
        sut = SearchCharacterUseCase()
        
        // When
        _ = sut!.execute(searchTerm: "batman")
        
        // Then
        XCTAssertTrue(mockSearchRepository.isSearchCalled)
    }
}
