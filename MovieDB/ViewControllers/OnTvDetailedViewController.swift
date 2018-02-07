//
//  DetailedViewController.swift
//  MovieDB
//
//  Created by Esther Donde on 08/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class OnTvDetailedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  
    
    @IBOutlet weak var detailedTableView: UITableView!
    var movie : MovieOnTV!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
       
        APIHandler.shared.getSeasons(forMovie: movie) {
            self.detailedTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            if indexPath.row == 0 {
                return 400
            }
        
        else {
            return 60
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !movie.seasons.isEmpty {
                return movie.seasons.count
            }
        else {
            return 1
        }
    }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailedCell") as! CustomTableViewCell
      let poster = URL (string: "\(APIHandler.shared.image300Url)" + movie.posterPath)
            if let poster = poster {
                cell.moviePosterImageView.imageUrl = poster }
      cell.genresLabel.text = dump(movie.genres?.joined(separator: ", "))
      cell.movieTitleLabel.text = movie.title
      cell.overviewTextField.text = movie.overview
      cell.votePic.image = #imageLiteral(resourceName: "yellow-star")
      return cell
        }
        else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "seasonCell")!
                    cell.textLabel?.text = "Season \(movie.seasons[indexPath.row].seasonNumber!)"

        
            return cell
    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let episodesViewController = segue.destination as? EpisodesViewController {
            episodesViewController.movie = movie
            episodesViewController.season = movie.seasons[(detailedTableView.indexPathForSelectedRow?.row)!]
        }

    }
    }
 

