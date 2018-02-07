//
//  Video.swift
//  MovieDB
//
//  Created by Esther Donde on 14/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import Foundation

class Video {
    var type : String
    var id : String
    var key : String
    var site : String
    
    init(type : String, id : String, key : String, site : String) {
        self.type = type
        self.id = id
        self.key = key
        self.site = site
    }
}
