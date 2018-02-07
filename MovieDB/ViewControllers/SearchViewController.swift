//
//  SearchViewController.swift
//  MovieDB
//
//  Created by Esther Donde on 12/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
   
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var searchTableView: UITableView!

    var filteredArray = [Movie] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchTableView.tableHeaderView = searchController.searchBar
        filteredArray = APIHandler.shared.searchArray
        
            APIHandler.shared.getTvGenres {
                self.searchTableView.reloadData()}
                APIHandler.shared.getInTheatersGenres {
                     self.searchTableView.reloadData()
                }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            APIHandler.shared.searchMovie(forQuery: searchText, completion: {

                APIHandler.shared.searchTvShows(forQuery: searchText, completion: {
                    self.filteredArray = searchText.isEmpty ? APIHandler.shared.searchArray : APIHandler.shared.searchArray.filter({ (searchedMovie) -> Bool in
                        return searchedMovie.title.lowercased().contains(searchText.lowercased())
                    })
                    self.searchTableView.reloadData()
                })
        })
        } else {
            filteredArray.removeAll()
            self.searchTableView.reloadData()
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
         filteredArray.removeAll()
        self.searchTableView.reloadData()
    }
    
    override func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        filteredArray.removeAll()
        self.searchTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        cell.votePic.image = #imageLiteral(resourceName: "yellow-star")
        let movie = filteredArray[indexPath.row]
        
        if let movieOnTV = movie as? MovieOnTV {
        let moviePoster = URL (string: "\(APIHandler.shared.image300Url)" + movieOnTV.posterPath)
        cell.relDateLabel.isHidden = true
        cell.relDateValueLabel.isHidden = true
        cell.titleLabel.text = movieOnTV.title
        cell.genresLabel.text = dump(movieOnTV.genres?.joined(separator: " , "))
        if moviePoster != nil {
            cell.imageViewLabel.imageUrl = moviePoster! }
            
            
        
        
        } else if let movieInTheaters = movie as? MovieInTheater {
            APIHandler.shared.getRunTime(forMovie: movieInTheaters, completion: {
                let moviePoster = URL (string: "\(APIHandler.shared.image300Url)" + movieInTheaters.posterPath)
                cell.titleLabel.text = movieInTheaters.title
                cell.genresLabel.text = dump(movieInTheaters.genres?.joined(separator: " , "))
                if moviePoster != nil {
                    cell.imageViewLabel.imageUrl = moviePoster!}
                cell.relDateValueLabel.text = movieInTheaters.releaseDate
                if movieInTheaters.runTime != nil {
                                        cell.runTimeValueLabel.text = "\(movieInTheaters.runTime!) min" }
            })
        
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = filteredArray[indexPath.row]
        if selectedMovie is MovieOnTV {
            performSegue(withIdentifier: "tv", sender: nil)
        } else if selectedMovie is MovieInTheater {
            performSegue(withIdentifier: "movie", sender: nil)
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedMovie = filteredArray [searchTableView.indexPathForSelectedRow!.row]
        if segue.identifier == "tv" {
            if let detailedViewController = segue.destination as? OnTvDetailedViewController {
                detailedViewController.movie = selectedMovie as! MovieOnTV
            }
        }
        if segue.identifier == "movie"{
        if let inTheatersDetailedViewController = segue.destination as? InTheatersDetailedViewController {
            inTheatersDetailedViewController.movie = selectedMovie as! MovieInTheater
        }
    }
}
}
