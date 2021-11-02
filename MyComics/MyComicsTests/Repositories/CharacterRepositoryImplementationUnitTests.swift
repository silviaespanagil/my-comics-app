//
//  CharacterRepositoryImplementationUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
import Combine
@testable import MyComics

class CharacterRepositoryImplementationUnitTests: XCTestCase {
    
    var sut: CharacterRepositoryImplementation!
    var local: LocalCharacterDataSource!
    
    var cancellable: AnyCancellable?
    
    let baseUrlString = "http://jsonplaceholder.typicode.com/"
    
    let successStatusCode = 200
    let failureStatusCode = 401
    let timeoutTime: TimeInterval = 2
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        local = LocalCharacterDataSource(dbManager: DBManager(coreDataStack: TestCoreDataStack()))
        
        sut = CharacterRepositoryImplementation(localDataSource: local)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        local = nil
        
        try super.tearDownWithError()
    }
    
    func testGetCharacterOK() {

        // Given
        let id = 1
        let session = getCharacterSession(statusCode: successStatusCode, id: id)
        
        let remote = RemoteCharacterDataSource(baseURL: baseUrlString, session: session)
        
        sut = CharacterRepositoryImplementation(remoteDataSource: remote)
        
        let exp = expectation(description: "expected values")
        
        // When
        cancellable = sut!.getCharacter(id: id)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .finished:
                    exp.fulfill()
                case .failure:
                    break
                }
                
            }, receiveValue: { character in
                
                XCTAssertEqual(character.id, 1)
                XCTAssertEqual(character.name, "Batman")
                XCTAssertEqual(character.realName, "Bruce Wayne")
                XCTAssertEqual(character.aliases, "Black Knight")
                XCTAssertEqual(character.birth, "birth")
                XCTAssertEqual(character.deck, "deck")
                XCTAssertEqual(character.gender, Gender.male)
            })
        
        wait(for: [exp], timeout: timeoutTime)
        
        // Then
        XCTAssertNotNil(cancellable)
    }
    
    func testGetCharacterError() {

        // Given
        let id = 1
        let session = getCharacterSession(statusCode: failureStatusCode, id: id)
        
        let remote = RemoteCharacterDataSource(baseURL: baseUrlString, session: session)
        
        sut = CharacterRepositoryImplementation(remoteDataSource: remote)
        
        let exp = expectation(description: "expected values")
        
        // When
        cancellable = sut!.getCharacter(id: id)
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
    
    func testSaveCharacter() {
        
        // Given
        let character = Character(id: 1,
                                  name: "",
                                  realName: "",
                                  aliases: "",
                                  image: nil,
                                  birth:"",
                                  deck: "",
                                  gender: .female,
                                  origin:"",
                                  powers: [])
        
        // When
        sut.saveCharacter(character: character)
        let characters = sut.getCharacters()
        
        // Then
        XCTAssertEqual(characters.count, 1)
    }
    
    func testRemoveCharacter() {
        
        // Given
        let character = Character(id: 1,
                                  name: "",
                                  realName: "",
                                  aliases: "",
                                  image: nil,
                                  birth:"",
                                  deck: "",
                                  gender: .female,
                                  origin:"",
                                  powers: [])
        
        // When
        sut.saveCharacter(character: character)
        let charactersSaved = sut.getCharacters()
        sut.removeCharacter(character: character)
        let charactersRemoved = sut.getCharacters()
        
        // Then
        XCTAssertEqual(charactersSaved.count, 1)
        XCTAssertEqual(charactersRemoved.count, 0)
    }
}

extension CharacterRepositoryImplementationUnitTests {
    
    func getCharacterSession(statusCode: Int, id: Int) -> URLSession {
        
        // URL we expect to call
        let url = URL(string: "http://jsonplaceholder.typicode.com/character/4005-\(id)?api_key=c470a425f528652de6ee58539d00793cb1bd5f7f&format=json&field_list=id,image,name,aliases,real_name,birth,deck,gender,origin,powers")
        
        // data we expect to receive
        let data = getCharacterData()
        
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
    
    func getCharacterData() -> Data {
        
        let dataString = """
                                {
                                "results": {
                                    "id": 1 ,
                                    "name": "Batman",
                                    "real_name": "Bruce Wayne",
                                    "aliases": "Black Knight",
                                    "birth": "birth",
                                    "deck": "deck",
                                    "image": {},
                                    "gender": 1,
                                    "origin": {
                                        "id": 4,
                                        "name": "Human"
                                    },
                                    "powers": [{
                                        "id": 3,
                                        "name": "Agility"
                                    }]
                                }
                                }
                    """

        return Data(dataString.utf8)
    }
}
