//
//  App+Injection.swift
//  MyComics
//
//  Created by Raul Garcia on 3/2/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {

      register { URLSession.shared }
      
      register { URL(string: Constants.baseURL) }
      
      register { ApiManager() }
      
      register { RemoteCharacterDataSource() }
      
      register { GetCharactersUseCase() }
      
      register { CharacterRepositoryImplementation() }.implements(CharacterRepository.self)
      
      
      
      register { RemoteSearchDataSource() }
      register { SearchRepositoryImplementation() }.implements(SearchRepository.self)
      register { SearchCharacterUseCase() }
      register { SearchViewModel() }
  }
}
