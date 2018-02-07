//
//  EpisodesFirstTableViewCell.swift
//  MovieDB
//
//  Created by Esther Donde on 13/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class EpisodesFirstTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seasonNumberLabel: UILabel!
    @IBOutlet weak var numberOfEpisodesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
