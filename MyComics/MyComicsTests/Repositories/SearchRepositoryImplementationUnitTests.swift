//
//  SearchRepositoryImplementationUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 18/10/21.
//

import XCTest
import Combine
@testable import MyComics

class SearchRepositoryImplementationUnitTests: XCTestCase {

    var sut: SearchRepositoryImplementation?
    var cancellable: AnyCancellable?
    
    let baseUrlString = "http://jsonplaceholder.typicode.com/"
    
    let successStatusCode = 200
    let failureStatusCode = 401
    let timeoutTime: TimeInterval = 2
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }

    // MARK: - Search

    func testGetSearchOK() {
        
        // Given
        let search = "batman"
        let session = getSearchSession(statusCode: successStatusCode)
        
        let remote = RemoteSearchDataSource(baseURL: baseUrlString, session: session)
        
        sut = SearchRepositoryImplementation(remoteDataSource: remote)
        
        let exp = expectation(description: "expected values")
        
        // When
        cancellable = sut!.searchCharacter(searchTerm: search)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .finished:
                    exp.fulfill()
                case .failure:
                    break
                }
                
            }, receiveValue: { searchElements in
                
                XCTAssertEqual(searchElements.count, 1)
                XCTAssertEqual(searchElements.first?.id, 1)
                XCTAssertEqual(searchElements.first?.name, "Batman")
                XCTAssertEqual(searchElements.first?.realName, "Bruce Wayne")
                XCTAssertEqual(searchElements.first?.aliases, "Black Knight")
            })
        
     wait(for: [exp], timeout: timeoutTime)
    
        // Then
        XCTAssertNotNil(cancellable)
    }
    
    func testGetSearchError() {
        
        // Given
        let search = "batman"
        let session = getSearchSession(statusCode: failureStatusCode)
        
        let remote = RemoteSearchDataSource(baseURL: baseUrlString, session: session)
        
        sut = SearchRepositoryImplementation(remoteDataSource: remote)
        
        let exp = expectation(description: "expected values")
        
        // When
        cancellable = sut!.searchCharacter(searchTerm: search)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .finished:
                    break
                case .failure:
                    exp.fulfill()
                }
                
            }, receiveValue: { searchElements in
                
                // Nothing to do
            })
        
        wait(for: [exp], timeout: timeoutTime)
        
        // Then
        XCTAssertNotNil(cancellable)
    }
}

extension SearchRepositoryImplementationUnitTests {
    
    func getSearchSession(statusCode: Int) -> URLSession {
        
        // URL we expect to call
        let url = URL(string: "http://jsonplaceholder.typicode.com/search/?api_key=c470a425f528652de6ee58539d00793cb1bd5f7f&query=batman&format=json&field_list=id,image,name,aliases,real_name,gender&resources=character&limit=100")
        
        // data we expect to receive
        let data = getSearchData()
        
        // attach that to some fixed data in our protocol handler
        URLProtocolMock.testURLs = [url: data]
        URLProtocolMock.response = HTTPURLResponse(url: URL(string: "http://jsonplaceholder.typicode.com:8080")!,
                                                   statusCode: statusCode,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        
        // now setup a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        // and ceate the URLSession form that
        let session = URLSession(configuration: config)
        
        return session
    }
    
    func getSearchData() -> Data {
        
        let dataString = """
                                {
                                "results": [{
                                    "id": 1 ,
                                    "name": "Batman",
                                    "real_name": "Bruce Wayne",
                                    "aliases": "Black Knight",
                                    "image": {},
                                    "gender": 1
                                }]
                                }
                    """

        return Data(dataString.utf8)
    }
}
