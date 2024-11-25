//
//  MovieGroundCarouselView.swift
//  JMDb
//
//  Created by Emre Yılmaz on 1.08.2024.
//

import SwiftUI

struct MovieGroundCarouselView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    ForEach(self.movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MovieGroundModel(movie: movie)
                                .frame(height: 250)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    MovieGroundCarouselView(title: "Latest", movies: Movie.draftMovies)
}
