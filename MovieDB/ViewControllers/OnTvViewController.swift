//
//  OnTvViewController.swift
//  MovieDB
//
//  Created by Esther Donde on 28/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class OnTvViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvTableView: UITableView!
    
    var moviesOnTv : [MovieOnTV]!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "On TV"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesOnTv.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "onTvCell") as! CustomTableViewCell
            cell.votePic.image = #imageLiteral(resourceName: "yellow-star")
            let movie = moviesOnTv [indexPath.row]
            
            let imagePoster = URL (string: APIHandler.shared.image300Url + movie.posterPath)
            cell.movieTitleLabel.text = movie.title
            cell.voteLabel.text = String(movie.voteAverage)
            cell.genresLabel.text = dump(movie.genres?.joined(separator: " ,"))
            cell.moviePosterImageView.imageUrl = imagePoster!
            
            return cell
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let onTvdetailedViewController = segue.destination as? OnTvDetailedViewController {
            let selectedMovie = moviesOnTv [tvTableView.indexPathForSelectedRow!.row]
            onTvdetailedViewController.movie = selectedMovie
        }
    }
    }

