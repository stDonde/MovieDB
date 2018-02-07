      //
//  APIHandler.swift
//  MovieDB
//
//  Created by Esther Donde on 03/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import Foundation
import UIKit

class APIHandler {
    static var shared = APIHandler ()
    private init () {}
    
    var moviesInTheater : [Movie] = []
    var moviesOnTV : [Movie] = []
    var popularTV : [Movie] = []
    var popularInTheaters : [Movie] = []
    var tvGenres : [Int : String] = [:]
    var searchArray : [Movie] = []
    
    private let apiKey = "?api_key=dba12daa07a6f94ad47c9b2788ba730b"
    private let baseURL = "https://api.themoviedb.org/3/"
    private let nowPlayingInTheatersURL = "movie/now_playing"
    private let nowPlayingOnTVURL = "tv/airing_today"
    private let genresTVList = "genre/tv/list"
    private let genresMovieList = "genre/movie/list"
    let image300Url = "https://image.tmdb.org/t/p/w300/"
    private let image500Url = "https://image.tmdb.org/t/p/w500/"
    private let popularTvURL = "tv/popular"
    private let popularInTheatersURL = "movie/popular"
    private let searchMovieURL = "search/movie"
    private let searchTvURL = "search/tv"
    let youtubeURL = "https://www.youtube.com/embed/"
    
    
    /// get TV genres ///
    func getTvGenres (completion : @escaping ()->()) {
        let genresURL = URL (string: baseURL + genresTVList + apiKey)
        URLSession.shared.dataTask(with: genresURL!) { (data, response, error) in
            if let data = data {
                var jsonGenres = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
               let genres  = jsonGenres! ["genres"] as? [[String:AnyObject]]
                for genre in genres! {
                    
                    self.tvGenres.updateValue(genre["name"] as! String, forKey: genre["id"] as! Int)
                    }
                DispatchQueue.main.async {
                    completion()
                }
            }
            }.resume()
    }
    
    /// genres Movie genres///
    func getInTheatersGenres (completion : @escaping ()->()) {
        let genresURL = URL (string: baseURL + genresMovieList + apiKey)
        URLSession.shared.dataTask(with: genresURL!) { (data, response, error) in
            if let data = data {
                var jsonGenres = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                let genres  = jsonGenres! ["genres"] as! [[String:AnyObject]]
               
                for genre in genres {
                    
                    self.tvGenres.updateValue(genre["name"]as! String, forKey: genre["id"] as! Int)
                    }
                DispatchQueue.main.async {
                    completion()
                }
            }
            }.resume()
    }
    /// now playing Movies ///
    func getAllMoviesInTheater(completion : @escaping ()->()){
        if moviesInTheater.count == 0 {
        let moviesURL = URL(string: baseURL + nowPlayingInTheatersURL + apiKey)
        URLSession.shared.dataTask(with: moviesURL!) { (data, response, error) in
            if let data = data {
                guard var jsonMovies  = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else {return}
                
                let results = jsonMovies ["results"] as? [[String : AnyObject]]
                    for jsonMovie in results! {
                        
                    let genresIds = jsonMovie ["genre_ids"] as! [Int]
                    let movie = MovieInTheater (title: jsonMovie ["title"] as! String,
                                                id: jsonMovie ["id"] as! Int,
                                                voteAverage: jsonMovie ["vote_average"] as! Float,
                                                releaseDate: jsonMovie ["release_date"] as! String,
                                                overview: jsonMovie ["overview"] as! String,
                                                posterPath: jsonMovie ["poster_path"] as! String)
                        movie.genres = movie.getGenres(ids: genresIds)
                        self.moviesInTheater.append(movie)
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }.resume()
        }
    }
    /// now playing TV ///
    func getAllMoviesOnTV(completion : @escaping ()->()){
        if moviesOnTV.count == 0 {
        let moviesURL = URL(string: baseURL + nowPlayingOnTVURL + apiKey)
        URLSession.shared.dataTask(with: moviesURL!) { (data, response, error) in
            if let data = data {
                guard var jsonMovies  = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else {return}
                
                let results = jsonMovies ["results"] as? [[String : AnyObject]]
                for jsonMovie in results! {
                    let genresIds = jsonMovie ["genre_ids"] as! [Int]
                    let tvMovie = MovieOnTV (
                                           title: jsonMovie ["original_name"] as! String,
                                           id: jsonMovie ["id"] as! Int,
                                           voteAverage: jsonMovie ["vote_average"] as! Float,
                                           overview: jsonMovie ["overview"] as! String,
                                           posterPath: jsonMovie ["poster_path"] as? String ?? "Poster not found")
                    tvMovie.genres = tvMovie.getGenres(ids: genresIds)
                    self.moviesOnTV.append(tvMovie)
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
            }.resume()
        }
    }
    
    
    ///// TV Tab /////
    
    func getPopularMoviesOnTV (completion : @escaping ()->()) {
        let popularURL = URL(string: baseURL + popularTvURL + apiKey)
        URLSession.shared.dataTask(with: popularURL!) { (data, response, error) in
            if let data = data {
                guard var jsonPopular = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else {return}
                
                let results = jsonPopular ["results"] as! [[String : AnyObject]]
                for jsonResult in results {
                    let genresIds = jsonResult ["genre_ids"] as! [Int]
                let tvMovie = MovieOnTV (title: jsonResult ["original_name"] as! String,
                                         id: jsonResult ["id"] as! Int,
                                         voteAverage: jsonResult ["vote_average"] as! Float,
                                         overview: jsonResult ["overview"] as! String,
                                         posterPath: jsonResult ["poster_path"] as! String)
                    tvMovie.genres = tvMovie.getGenres(ids: genresIds)
                    self.popularTV.append(tvMovie)
                }
                DispatchQueue.main.async {
                    completion ()
                }
            }
        }.resume()
    }
    
    ///// Movie Tab ///////
    
    func getPopularMoviesInTheaters (completion : @escaping ()->()) {
        let popularURL = URL(string: baseURL + popularInTheatersURL + apiKey)
        URLSession.shared.dataTask(with: popularURL!) { (data, response, error) in
            if let data = data {
                guard var jsonPopular = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else {return}
                
                let results = jsonPopular ["results"] as! [[String : AnyObject]]
                for jsonResult in results {
                    let genresIds = jsonResult ["genre_ids"] as! [Int]
                    let movie = MovieInTheater (title: jsonResult ["original_title"] as! String,
                                             id: jsonResult ["id"] as! Int,
                                             voteAverage: jsonResult ["vote_average"] as! Float,
                                             releaseDate: jsonResult ["release_date"] as! String,
                                             overview: jsonResult ["overview"] as! String,
                                             posterPath: jsonResult ["poster_path"] as! String)
                    movie.genres = movie.getGenres(ids: genresIds)
                    self.popularInTheaters.append(movie)
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }.resume()
    }
//    get Seasons //
    
    func getSeasons (forMovie movie : MovieOnTV ,completion : @escaping ()->()) {
        let seasonsURL = URL(string: baseURL + "tv/\(movie.id)" + apiKey)
        URLSession.shared.dataTask(with: seasonsURL!) { (data, response, error) in
            if let data = data {
                guard var jsonResult = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else { return }
                
                let jsonSeasons = jsonResult ["seasons"] as! [[String : AnyObject]]
                for season in jsonSeasons {
                    let tvSeason = Season ()
                    tvSeason.seasonNumber = season ["season_number"] as? Int
                    tvSeason.posterPath = season ["poster_path"] as? String
                    movie.seasons.append(tvSeason)
                }
            
            DispatchQueue.main.async {
                completion ()
            }
            }
        }.resume()
    }

    /// episodes ///
    
    func getEpisodes (forShow show: MovieOnTV, season : Season, completion : @escaping ()->()) {
        let episodesUrl = URL (string: baseURL + "tv/\(show.id)/season/\(season.seasonNumber!)" + apiKey)
        URLSession.shared.dataTask(with: episodesUrl!) { (data, response, error) in
            if let data = data {
                guard var jsonResult = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else { return }
                let jsonEpisodes = jsonResult ["episodes"] as! [[String : AnyObject]]
                for jsonEpisode in jsonEpisodes {
                    let episode = Episode (id: jsonEpisode ["id"] as! Int,
                                           name: jsonEpisode ["name"] as! String,
                                           episodeNumber: jsonEpisode ["episode_number"] as! Int,
                                           airDate: jsonEpisode ["air_date"] as? String ?? "not found",
                                           overview: jsonEpisode ["overview"] as! String,
                                           posterPath: jsonEpisode ["still_path"] as? String ?? "Poster not found")
                    season.episodes.append(episode)
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }.resume()
    }
    
    /// search tv ///
    func searchTvShows (forQuery query: String, completion : @escaping ()->() ) {
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
      let searchURL = URL(string: baseURL + searchTvURL + apiKey + "&query=\(escapedQuery!)")
        URLSession.shared.dataTask(with: searchURL!) { (data, response, error) in
                        if let data = data {
                            guard var jsonResult = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else { return }
            
                            let searchResults = jsonResult ["results"] as! [[String : AnyObject]]
            
                            for searchResult in searchResults {
                                let genres = searchResult ["genre_ids"] as? [Int]
                                let movie = MovieOnTV (title: searchResult ["name"] as! String,
                                                        id: searchResult ["id"] as! Int,
                                                        voteAverage: searchResult ["vote_average"] as! Float,
                                                        overview: searchResult ["overview"] as! String,
                                                        posterPath: searchResult ["poster_path"] as? String ?? "posterPath did not found")
                                movie.genres = movie.getGenres(ids: genres!)
                                self.searchArray.append(movie)}
                            }
                            DispatchQueue.main.async {
                                completion ()
                    }
            
    }.resume()
    }
    
    /// search movie ///
    func searchMovie (forQuery query: String, completion : @escaping ()->() ) {
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let searchURL = URL(string: baseURL + searchMovieURL + apiKey + "&query=\(escapedQuery!)")
        URLSession.shared.dataTask(with: searchURL!) { (data, response, error) in
            if let data = data {
                guard var jsonResult = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else { return }
                
                let searchResults = jsonResult ["results"] as! [[String : AnyObject]]
                
                for searchResult in searchResults {
                    let genres = searchResult ["genre_ids"] as? [Int]
                   let movie = MovieInTheater (title: searchResult ["title"] as! String,
                                    id: searchResult ["id"] as! Int,
                                    voteAverage: searchResult ["vote_average"] as! Float,
                                    releaseDate: searchResult ["release_date"] as! String,
                                    overview: searchResult ["overview"] as! String,
                                    posterPath: searchResult ["poster_path"] as? String ?? "posterPath did not found")
                    
                    movie.genres = movie.getGenres(ids: genres!)
                    self.searchArray.append(movie)}
                }
                DispatchQueue.main.async {
                    completion ()
                }
            }.resume()
            }
    
    
    
    /// getRunTime ///
    func getRunTime (forMovie movie : MovieInTheater, completion : @escaping ()->()) {
        let runTimeURL = URL(string: baseURL + "movie/\(movie.id)" + apiKey)
        URLSession.shared.dataTask(with: runTimeURL!) { (data, response, error) in
            if let data = data {
                guard var jsonResult = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else { return }
                
          movie.runTime = jsonResult ["runtime"] as? Int
                
                DispatchQueue.main.async {
                    completion ()
                }
            }
        }.resume()
    }

    /// getVideos //
    func getVideos(forMovie movie : MovieInTheater, completion : @escaping ()->()) {
        let videoUrl = URL (string: baseURL + "movie/\(movie.id)/videos" + apiKey)
        URLSession.shared.dataTask(with: videoUrl!) { (data, response, error) in
            if let data = data {
            guard var jsonResult = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject] else { return }
            
                let results = jsonResult ["results"] as! [[String : AnyObject]]
                for result in results {
                    let video = Video (type: result ["type"] as! String,
                                       id: result ["id"] as! String,
                                       key: result ["key"] as! String,
                                       site: result ["site"] as! String)
                    movie.videos.append(video)
                }
                DispatchQueue.main.async {
                    completion ()
                }
            }
        }.resume()
    }
    
   
}





