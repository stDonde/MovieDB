//
//  MoviesInTheaterListViewController.swift
//  MovieDB
//
//  Created by Esther Donde on 28/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class MoviesInTheaterListViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
      
    var moviesInTheater : [MovieInTheater]!
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "In Theaters"
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesInTheater.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inTheatersCell") as! CustomTableViewCell
         let movie = moviesInTheater [indexPath.row]
            let imagePoster = URL (string: "\(APIHandler.shared.image300Url)" + movie.posterPath)
            cell.movieTitleLabel.text = movie.title
            cell.releaseDateLabel.text = movie.releaseDate
            cell.voteLabel.text = String(movie.voteAverage)
            cell.moviePosterImageView.imageUrl = imagePoster!
            cell.genresLabel.text = dump(movie.genres?.joined(separator: " , "))
            cell.votePic.image = #imageLiteral(resourceName: "yellow-star")
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let inTheatersDetailedViewController = segue.destination as? InTheatersDetailedViewController {
            inTheatersDetailedViewController.movie = moviesInTheater[(moviesTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    

}
