//
//  MoviePosterModel.swift
//  JMDb
//
//  Created by Emre Yılmaz on 2.08.2024.
//

import SwiftUI

struct MoviePosterModel: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    
    var body: some View {
        ZStack{
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
            }
            else{
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                Text(movie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 144, height: 206)
        .onAppear{
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
    }
}

#Preview {
    MoviePosterModel(movie: Movie.draftMovie)
}
