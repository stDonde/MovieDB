//
//  MovieOnTV.swift
//  MovieDB
//
//  Created by Esther Donde on 05/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import Foundation

class MovieOnTV : Movie {
    var seasons : [Season] = []
    
    override init(title : String, id : Int, voteAverage: Float, overview: String, posterPath : String) {
        
        super.init(title: title, id : id, voteAverage: voteAverage, overview: overview, posterPath: posterPath)
        
    }
    
}

