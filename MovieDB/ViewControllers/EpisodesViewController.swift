//
//  EpisodesViewController.swift
//  MovieDB
//
//  Created by Esther Donde on 13/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var episodesTableView: UITableView!
    var season : Season!
      var movie : MovieOnTV!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Season \(season.seasonNumber!)"
        APIHandler.shared.getEpisodes(forShow: movie, season: season) {
            self.episodesTableView.reloadData()
        }
        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var counter = 1
        if !season.episodes.isEmpty {
            counter += 1
        }
        return counter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return season.episodes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell ()
        switch indexPath.section {
        case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "seasonCell") as! EpisodesFirstTableViewCell
            if let posterpath = season.posterPath {
                let poster = URL (string: APIHandler.shared.image300Url + posterpath)
                cell1.posterImageView.imageUrl = poster!}
            
            cell1.seasonNumberLabel.text = "Season \(season.seasonNumber!)"
            cell1.titleLabel.text = movie.title
            cell1.numberOfEpisodesLabel.text = "\(season.episodes.count) episodes"
           cell = cell1
        case 1:
            let poster = URL (string: APIHandler.shared.image300Url + season.episodes[indexPath.row].posterPath)
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as! EpisodesSecondTableViewCell
            if (poster != nil) {
                    cell2.posterImageView.imageUrl = poster! }
            cell2.episodeNumberLabel.text =  "Episode \(season.episodes[indexPath.row].episodeNumber)"
            cell2.titleLabel.text = season.episodes[indexPath.row].name
            cell2.overviewTextView.text = season.episodes[indexPath.row].overview
            cell2.airDateLabel.text = season.episodes[indexPath.row].airDate
            cell = cell2
        default:
            break
        }
        return cell
    }

}
