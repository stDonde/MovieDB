//
//  MovieInTheater.swift
//  MovieDB
//
//  Created by Esther Donde on 03/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import Foundation
import UIKit
class MovieInTheater : Movie {
   
    var releaseDate : String
    var runTime : Int?
    var videos : [Video] = []
    var poster : UIImage?
    
    init(title : String, id : Int, voteAverage : Float, releaseDate : String, overview : String, posterPath : String) {
        self.releaseDate = releaseDate
        
        super.init(title: title, id: id, voteAverage: voteAverage, overview: overview, posterPath: posterPath)
    }
    
}
