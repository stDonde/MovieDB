//
//  Movie.swift
//  MovieDB
//
//  Created by Esther Donde on 05/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    var title : String
    var id : Int
    var voteAverage : Float
    var genres: [String]?
    var overview : String
    var posterPath : String
    
    
    init(title : String, id : Int, voteAverage : Float,  overview : String, posterPath : String) {
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.posterPath = posterPath
        self.id = id
    }
    
    func getGenres (ids : [Int]) -> [String] {
        var values : [String] = []
        for id in ids{
            if APIHandler.shared.tvGenres[id] != nil {
                values.append(APIHandler.shared.tvGenres[id]!)}
        }
        return values
    }
    
}
