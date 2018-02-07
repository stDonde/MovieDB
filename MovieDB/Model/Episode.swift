//
//  Episode.swift
//  MovieDB
//
//  Created by Esther Donde on 05/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import Foundation

class Episode {
    var id : Int
    var name : String
    var episodeNumber : Int
    var airDate : String
    var overview : String
    var posterPath : String
    
    init(id : Int, name : String, episodeNumber : Int, airDate : String, overview : String, posterPath : String ) {
        self.id = id
        self.name = name
        self.episodeNumber = episodeNumber
        self.airDate = airDate
        self.overview = overview
        self.posterPath = posterPath
    }
}
