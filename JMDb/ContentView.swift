//
//  ContentView.swift
//  JMDb
//
//  Created by Emre Yılmaz on 31.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: Tab = .Home

    var body: some View {
        ZStack {
            Color("mainColor")
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                if currentTab == .Home {
                    MovieListView()
                } else if currentTab == .Search {
                    MovieSearchView()
                } else if currentTab == .Heart {
                    FavoritesView()
                }

                Spacer()

                HStack {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        TabButton(tab: tab)
                    }
                }
                .padding(.vertical, 4)
                .background(Color("mainColor"))
                .cornerRadius(10)
                .padding(.horizontal, 8)
            }
        }
    }

    func TabButton(tab: Tab) -> some View {
        Button(action: {
            withAnimation(.spring()) {
                currentTab = tab
            }
        }, label: {
            VStack(spacing: 0) {
                Image(systemName: currentTab == tab ? "\(tab.rawValue).fill" : tab.rawValue)
                    .font(.system(size: 20))
                    .foregroundColor(currentTab == tab ? .gray : .black)
                Text(tab.TabName)
                    .font(.footnote)
                    .foregroundColor(currentTab == tab ? .gray : .black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(currentTab == tab ? Color("secondColor") : Color.clear)
            .cornerRadius(10)
            .padding(.vertical, 4)
        })
    }
}

#Preview {
    ContentView()
}


enum Tab: String, CaseIterable {
    case Home = "house"
    case Search = "magnifyingglass.circle"
    case Heart = "heart"

    var TabName: String {
        switch self {
        case .Home:
            return "Home"
        case .Search:
            return "Search"
        case .Heart:
            return "Favorites"
        }
    }
}
