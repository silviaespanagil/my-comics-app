//
//  RemoteSearchDataSourceUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 18/10/21.
//

import XCTest
@testable import MyComics

class RemoteSearchDataSourceUnitTests: XCTestCase {

    var sut: RemoteSearchDataSource?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        sut = RemoteSearchDataSource(baseURL: "http://jsonplaceholder.typicode.com/")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testGetSearchCharacterEndpoint() {
        
        // Given
        let request = "search/"
        
        // When
        let response = sut!.getSearchCharacterEndpoint(searchTerm: request)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertEqual(response.url?.absoluteString.split(separator: "?").first, "http://jsonplaceholder.typicode.com/\(request)")
    }
}
