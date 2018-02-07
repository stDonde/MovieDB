//
//  SearchTableViewCell.swift
//  MovieDB
//
//  Created by Esther Donde on 19/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var voteLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var imageViewLabel: UIImageView!
   
    @IBOutlet weak var genresLabel: UILabel!
    
    @IBOutlet weak var relDateValueLabel: UILabel!
  
    @IBOutlet weak var relDateLabel: UILabel!
    
    @IBOutlet weak var runTimeValueLabel: UILabel!
    
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var votePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
