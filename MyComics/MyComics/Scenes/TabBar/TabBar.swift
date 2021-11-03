//
//  TabBar.swift
//  MyComics
//
//  Created by Silvia España on 21/10/21.
//

import SwiftUI

struct TabBar: View {
    
    @State var activeTab: Tab = Tab.search
    @Environment(\.colorScheme) var currentMode
    
    init() {
        
        tabBarApperance()
    }
    
    var body: some View {
        
        TabView(selection: $activeTab) {
            
            SearchView(viewModel: SearchViewModel())
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(Tab.search)
            
            FavoriteListView(viewModel: FavoriteListViewModel())
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
                .tag(Tab.favorites)
        }
        .navigationTitle(getNavBarTitle(for: activeTab))
        .navigationBarTitleDisplayMode(.large)

    }
    
    func getNavBarTitle(for tabItemType: Tab) -> String {
        
        switch tabItemType {
        case .search:
            return "Search"
        case .favorites:
            return "My Favorites"
        }
    }
}

extension TabBar {
    
        func tabBarApperance() {
        
        UITabBar.appearance().barTintColor = (backgroundColor() as? UIColor)
            UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
}

func backgroundColor() -> Any {
    
    @Environment(\.colorScheme) var currentMode
    
    if currentMode == .dark {
        return UIColor.black
    }
    else {
        return UIColor.white
    }
}

struct TabBar_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TabBar()
    }
}
