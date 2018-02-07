//
//  MainPageTableViewCell.swift
//  MovieDB
//
//  Created by Esther Donde on 03/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    @IBOutlet weak var nowPlayingMoviesCountLabel: UILabel!
    @IBOutlet weak var nowPlayingMoviesTitlesLabel: UILabel!
    @IBOutlet weak var firstMoviePosterImageView: UIImageView!
    @IBOutlet weak var secondMoviePosterImageView: UIImageView!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
