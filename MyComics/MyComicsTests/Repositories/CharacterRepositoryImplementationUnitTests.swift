//
//  CharacterRepositoryImplementationUnitTests.swift
//  MyComicsTests
//
//  Created by Xavi on 28/10/21.
//

import XCTest
@testable import MyComics

class CharacterRepositoryImplementationUnitTests: XCTestCase {
    
    var sut: CharacterRepositoryImplementation?
    let local = LocalCharacterDataSource()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testGetCharacterIsCalled() {
        
        //given
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
        
        let remote = RemoteCharacterDataSource()
        
        
        //when
        _ = sut?.getCharacter(id: 1)
        
        //then
        
        XCTAssertNotNil(remote.getCharacter(id: character.id))
    }
    
    
    func testSaveCharacterIsCalled() {
        
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
        
        _ = sut?.saveCharacter(character: character)
        
        XCTAssertNotNil(local.saveCharacter(character: character))
    }
    
    func testRemoveCharacterIsCalled() {
        
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
        
        _ = sut?.removeCharacter(character: character)
        
        XCTAssertNotNil(local.removeCharacter(character: character))
    }
    
    func testGetCharacterCalled() {
        
        _ = sut?.getCharacters()
        
        XCTAssertNotNil(local.getCharacters)
    }
}
