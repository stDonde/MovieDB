//
//  InTheatersTableViewCell.swift
//  MovieDB
//
//  Created by Esther Donde on 28/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var voteLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    @IBOutlet weak var runTimeLabel: UILabel!
    
    @IBOutlet weak var overviewTextField: UITextView!
    
    @IBOutlet weak var releaseDt: UILabel!
    
    @IBOutlet weak var runTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
