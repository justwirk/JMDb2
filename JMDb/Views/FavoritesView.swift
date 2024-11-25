//
//  FavoritesView.swift
//  JMDb
//
//  Created by Emre Yılmaz on 7.08.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesManager = FavoritesManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favoritesManager.favoriteMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                        HStack {
                            Text(movie.title)
                            Spacer()
                            Image(systemName: "heart.fill").foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationBarTitle("Your Favorites")
        }
    }
}
