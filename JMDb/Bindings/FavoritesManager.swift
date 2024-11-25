//
//  FavoritesManager.swift
//  JMDb
//
//  Created by Emre Yılmaz on 7.08.2024.
//

import Foundation

class FavoritesManager: ObservableObject {
    @Published var favoriteMovies: [Movie] = []
    
    private let defaults = UserDefaults.standard
    private let favoritesKey = "favoriteMovies"
    
    init() {
        loadFavorites()
    }
    
    func addFavorite(movie: Movie) {
        if !isFavorite(movie: movie) {
            favoriteMovies.append(movie)
            saveFavorites()
        }
    }
    
    func removeFavorite(movie: Movie) {
        if let index = favoriteMovies.firstIndex(of: movie) {
            favoriteMovies.remove(at: index)
            saveFavorites()
        }
    }
    
    func isFavorite(movie: Movie) -> Bool {
        return favoriteMovies.contains(movie)
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteMovies) {
            defaults.set(encoded, forKey: favoritesKey)
        }
    }
    
    private func loadFavorites() {
        if let savedMovies = defaults.data(forKey: favoritesKey),
           let decodedMovies = try? JSONDecoder().decode([Movie].self, from: savedMovies) {
            favoriteMovies = decodedMovies
        }
    }
}
