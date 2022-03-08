//
//  Resolver+XCTest.swift
//  MyComicsTests
//
//  Created by Raul Garcia on 4/2/22.
//

import Foundation
import Resolver
@testable import MyComics

extension Resolver {

    static var successStatusCode = 200
    static var failureStatusCode = 401
    
    // MARK: - Mock Container
  static var mock = Resolver(child: main)
    
    // MARK: - Mock Container
  static var mockCharacter = Resolver(child: main)
    
    // MARK: - Mock Container
  static var mockCharacterError = Resolver(child: main)
    
    // MARK: - Mock Search Container
  static var mockSearchCharacter = Resolver(child: main)

  // MARK: - Register Mock Services
    static func registerMockServices() {
        Resolver.root = Resolver.mock
    defaultScope = .application
        Resolver.mock.register { URL(string: "http://jsonplaceholder.typicode.com/") }
        Resolver.mock.register { ApiManager() }
        Resolver.mock.register { MockSearchRepository() }
          .implements(SearchRepository.self)
        
        
    Resolver.mock.register { MockCharacterRepository() }
      .implements(CharacterRepository.self)
    }
    
    // MARK: - Register mockCharacter Services
      static func registerMockCharacterServices() {
          Resolver.reset()
          Resolver.root = Resolver.mockCharacter
          defaultScope = .application
          
          Resolver.mockCharacter.register { URL(string: "http://jsonplaceholder.typicode.com/") }
          Resolver.mockCharacter.register { getCharacterSession(statusCode: successStatusCode, id: 1) }
          Resolver.mockCharacter.register { ApiManager() }
          Resolver.mockCharacter.register { MockSearchRepository() }
                .implements(SearchRepository.self)
          
          Resolver.mockCharacter.register { MockCharacterRepository() }
            .implements(CharacterRepository.self)
    
         
      }
        
    // MARK: - Register mockCharacterError Services
      static func registerMockCharacterErrorServices() {
          Resolver.root = Resolver.mockCharacterError
          defaultScope = .application
          
          Resolver.mockCharacterError.register { URL(string: "http://jsonplaceholder.typicode.com/") }
          Resolver.mockCharacterError.register { getCharacterSession(statusCode: failureStatusCode, id: 1) }
          Resolver.mockCharacter.register { ApiManager() }
          Resolver.mockCharacterError.register { MockSearchRepository() }
            .implements(SearchRepository.self)
              
          Resolver.mockCharacterError.register { MockCharacterRepository() }
            .implements(CharacterRepository.self)
    
      }
    
    // MARK: - Register mockSearchCharacter Services
      static func registerMockSearchCharacterServices() {
          Resolver.reset()
          Resolver.root = Resolver.mockSearchCharacter
          defaultScope = .application
          
          Resolver.mockSearchCharacter.register { URL(string: "http://jsonplaceholder.typicode.com/") }
          Resolver.mockSearchCharacter.register { getSearchSession(statusCode: successStatusCode) }
          Resolver.mockSearchCharacter.register { ApiManager() }
          Resolver.mockSearchCharacter.register { RemoteSearchDataSource() }
          Resolver.mockSearchCharacter.register { MockSearchRepository() }
            .implements(SearchRepository.self)
       
      }
}


 func getCharacterSession(statusCode: Int, id: Int) -> URLSession {
    
    // URL we expect to call
    let url = URL(string: "http://jsonplaceholder.typicode.com/character/4005-\(id)?api_key=\(Constants.apiKey)&format=json&field_list=id,image,name,aliases,real_name,birth,deck,gender,origin,powers")
    
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

func getSearchSession(statusCode: Int) -> URLSession {
    
    // URL we expect to call
    let url = URL(string: "http://jsonplaceholder.typicode.com/search/?api_key=\(Constants.apiKey)&query=batman&format=json&field_list=id,image,name,aliases,real_name,gender&resources=character&limit=100")
    
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
