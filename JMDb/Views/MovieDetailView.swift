//
//  MovieDetailView.swift
//  JMDb
//
//  Created by Emre Yılmaz on 2.08.2024.
//

import SwiftUI

struct MovieDetailView: View {
    
    
    
    let movieId: Int
    @ObservedObject private var movieDetailManager = MovieDetailManager()
    
    var body: some View {
        ZStack {
            Color("secondColor")
                .edgesIgnoringSafeArea(.all) 

            LoadingView(isLoading: self.movieDetailManager.isLoading, error: self.movieDetailManager.error) {
                self.movieDetailManager.loadMovie(id: self.movieId)
            }
            
            if movieDetailManager.movie != nil {
                MovieDetailListView(movie: self.movieDetailManager.movie!)
            }
        }
        .navigationBarTitle(movieDetailManager.movie?.title ?? "")
        .onAppear {
            self.movieDetailManager.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    @State private var isFavorite: Bool = false
    let movie: Movie
    @State private var selectedTrailer: MovieVideo?
    let imageLoader = ImageLoader()
    
    @ObservedObject var favoritesManager = FavoritesManager()

    var body: some View {
        List {
            MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color("secondColor"))
            
            HStack {
                Text(movie.genreText)
                Text("·")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            .listRowBackground(Color("secondColor"))

            HStack {
                Spacer()
                Button(action: {
                    if self.isFavorite {
                        self.favoritesManager.removeFavorite(movie: self.movie)
                    } else {
                        self.favoritesManager.addFavorite(movie: self.movie)
                    }
                    self.isFavorite.toggle()
                }) {
                    Image(systemName: self.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(self.isFavorite ? .red : .gray)
                }
                .padding()
            }
            .listRowBackground(Color("secondColor"))
            
            Text(movie.overview)
                .listRowBackground(Color("secondColor"))

            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            .listRowBackground(Color("secondColor"))

            

            if let trailers = movie.youtubeTrailers, !trailers.isEmpty {
                Text("Trailers")
                    .font(.headline)
                            .foregroundColor(.black)
                            .listRowBackground(Color.clear)
                ForEach(trailers) { trailer in
                    Button(action: {
                        self.selectedTrailer = trailer
                    }) {
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color.blue)
                        }
                    }
                }
                .listRowBackground(Color("secondColor"))
            }
        }
        .background(Color("secondColor"))
        .scrollContentBackground(.hidden)
        .sheet(item: self.$selectedTrailer) { trailer in
            SafariView(url: trailer.youtubeURL!)
        }
        .onAppear {
            self.isFavorite = self.favoritesManager.isFavorite(movie: self.movie)
        }
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if let image = self.imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

#Preview {
    MovieDetailView(movieId: Movie.draftMovie.id)
}
