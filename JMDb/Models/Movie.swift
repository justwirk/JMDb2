//
//  Movie.swift
//  JMDb
//
//  Created by Emre Yılmaz on 1.08.2024.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Encodable, Identifiable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    let genres: [MovieGenre]?

    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()

    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }

    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }

    var genreText: String {
        genres?.first?.name ?? "n/a"
    }

    struct MovieCredit: Decodable, Encodable {
        let cast: [MovieCast]
        let crew: [MovieCrew]
    }

    struct MovieCast: Decodable, Encodable, Identifiable {
        let id: Int
        let character: String
        let name: String
    }

    struct MovieCrew: Decodable, Encodable, Identifiable {
        let id: Int
        let job: String
        let name: String
    }

    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }

    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }

    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }

    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }

    var cast: [MovieCast]? {
        credits?.cast
    }

    var crew: [MovieCrew]? {
        credits?.crew
    }

    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }

    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }

    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }

    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
}

struct MovieGenre: Decodable, Encodable {
    let name: String
}

struct MovieVideoResponse: Decodable, Encodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Encodable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String

    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
