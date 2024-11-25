//
//  MovieDraft.swift
//  JMDb
//
//  Created by Emre Yılmaz on 1.08.2024.
//

import Foundation

extension Movie{
    
    static var draftMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    static var draftMovie: Movie {
        draftMovies[0]
    }
    
    
}

extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        
        guard let url = self.url(forResource: filename, withExtension: "json") else{
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodeModel = try jsonDecoder.decode(D.self, from: data)
        return decodeModel
    }
}
