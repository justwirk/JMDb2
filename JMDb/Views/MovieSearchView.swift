//
//  MovieSearchView.swift
//  JMDb
//
//  Created by Emre Yılmaz on 5.08.2024.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchManager()
    
    var body: some View {
        NavigationView{
            List{
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchState.query)
                
                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                
                if self.movieSearchState.movies != nil {
                    ForEach(self.movieSearchState.movies!){ movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)){
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                Text(movie.yearText)
                            }
                            .padding(.vertical, 8)
                            .background(Color("secondColor"))
                        }
                        .listRowBackground(Color("secondColor"))
                    }
                }
            }
            .onAppear{
                self.movieSearchState.startObserve()
            }
            .navigationBarTitle("Search Movie")
        }
    }
}

#Preview {
    MovieSearchView()
}
