//
//  EpisodesSecondTableViewCell.swift
//  MovieDB
//
//  Created by Esther Donde on 13/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class EpisodesSecondTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var episodeNumberLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
