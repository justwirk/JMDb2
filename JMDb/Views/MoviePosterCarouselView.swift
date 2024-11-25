//
//  MoviePosterCarouselView.swift
//  JMDb
//
//  Created by Emre Yılmaz on 2.08.2024.
//

import SwiftUI

struct MoviePosterCarouselView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 18) {
                    ForEach(Array(movies.chunked(into: 2)), id: \.self) { pair in
                        HStack(spacing: 1) {
                            ForEach(pair, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                    MoviePosterModel(movie: movie)
                                        .frame(width: UIScreen.main.bounds.width / 2 - 34)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            if pair.count == 1 {
                                Spacer()
                                    .frame(width: UIScreen.main.bounds.width / 2 - 24)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    MoviePosterCarouselView(title: "Now Playing", movies: Movie.draftMovies)
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
