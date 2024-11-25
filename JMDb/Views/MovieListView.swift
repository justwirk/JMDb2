//
//  MovieListView.swift
//  JMDb
//
//  Created by Emre Yılmaz on 2.08.2024.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListManager()
    @ObservedObject private var upcomingState = MovieListManager()
    @ObservedObject private var topRateState = MovieListManager()
    @ObservedObject private var popularState = MovieListManager()
    
    @State private var selectedCategory: MovieCategory = .nowPlaying
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("secondColor")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    Text("JMDb")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top)
                    HStack {
                        CategoryButton(title: "Now Playing", category: .nowPlaying, selectedCategory: $selectedCategory)
                        CategoryButton(title: "Upcoming", category: .upcoming, selectedCategory: $selectedCategory)
                        CategoryButton(title: "Top Rated", category: .topRated, selectedCategory: $selectedCategory)
                        CategoryButton(title: "Popular", category: .popular, selectedCategory: $selectedCategory)
                    }
                    .padding()
                    
                    List {
                        MoviePosterCarouselView(title: selectedCategory.title, movies: getMovies(for: selectedCategory))
                            .listRowBackground(Color("secondColor")) // Satırın arka planı
                    }
                    .background(Color("secondColor")) // Listenin arka planı
                    .scrollContentBackground(.hidden) // Scroll arka planını gizleme
                }
                
        
            }
            .onAppear {
                self.nowPlayingState.loadMovies(with: .nowPlaying)
                self.upcomingState.loadMovies(with: .upcoming)
                self.topRateState.loadMovies(with: .topRated)
                self.popularState.loadMovies(with: .popular)
            }
        }
    }
    


    
    private func getMovies(for category: MovieCategory) -> [Movie] {
        switch category {
        case .nowPlaying:
            return nowPlayingState.movies ?? []
        case .upcoming:
            return upcomingState.movies ?? []
        case .topRated:
            return topRateState.movies ?? []
        case .popular:
            return popularState.movies ?? []
        }
    }
}

enum MovieCategory {
    case nowPlaying
    case upcoming
    case topRated
    case popular
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
        }
    }
}

struct CategoryButton: View {
    let title: String
    let category: MovieCategory
    @Binding var selectedCategory: MovieCategory
    
    var body: some View {
        Button(action: {
            selectedCategory = category
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(selectedCategory == category ? .white : .gray)
                .padding()
                .background(selectedCategory == category ? Color("mainColor") : Color.clear)
                .cornerRadius(8)
        }
    }
}

#Preview {
    MovieListView()
}
