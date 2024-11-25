//
//  MovieGroundModel.swift
//  JMDb
//
//  Created by Emre Yılmaz on 1.08.2024.
//

import SwiftUI

struct MovieGroundModel: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                if self.imageLoader.image != nil{
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            Text(movie.title)
        }
        .lineLimit(1)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropURL)
        }
    }
}

#Preview {
    MovieGroundModel(movie: Movie.draftMovie)
}
