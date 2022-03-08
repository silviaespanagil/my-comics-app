//
//  CharacterRepositoryImplementationUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//
import Resolver
import XCTest
import Combine
@testable import MyComics

class CharacterRepositoryImplementationUnitTests: XCTestCase {
    
    @LazyInjected var remoteCharacterDataSource: RemoteCharacterDataSource
    
    var sut: CharacterRepositoryImplementation!
    var local: LocalCharacterDataSource!
    
    var cancellable: AnyCancellable?
    
    let timeoutTime: TimeInterval = 10
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        local = LocalCharacterDataSource(dbManager: DBManager(coreDataStack: TestCoreDataStack()))
        Resolver.registerMockCharacterServices()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        local = nil
        super.tearDown()
    }
    
    func testGetCharacterOK() {
        
        let id = 1
        sut = CharacterRepositoryImplementation()
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
        Resolver.registerMockCharacterErrorServices()
        
        let id = 1
        
        sut = CharacterRepositoryImplementation()
        
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
        sut = CharacterRepositoryImplementation(localDataSource: local)
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
        Resolver.registerMockCharacterServices()
        // Given
        sut = CharacterRepositoryImplementation(localDataSource: local)
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
