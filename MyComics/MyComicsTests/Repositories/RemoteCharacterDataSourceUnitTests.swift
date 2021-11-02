//
//  RemoteCharacterDataSourceUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics

class RemoteCharacterDataSourceUnitTests: XCTestCase {

    var sut: RemoteCharacterDataSource?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        sut = RemoteCharacterDataSource(baseURL: "http://jsonplaceholder.typicode.com/")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    func testCharacterEndpoint() {
        
        // Given
        let request = 1
        
        // When
        let response = sut!.getCharacterEndpoint(id: request)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertEqual(response.url?.absoluteString.split(separator: "?").first, "http://jsonplaceholder.typicode.com/character/4005-\(request)")
    }
}
