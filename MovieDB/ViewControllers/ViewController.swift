 //
//  ViewController.swift
//  MovieDB
//
//  Created by Esther Donde on 03/11/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

 class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var mainTableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
            APIHandler.shared.getInTheatersGenres {
                APIHandler.shared.getAllMoviesInTheater {
                    self.mainTableView.reloadData()
                }
        }
                APIHandler.shared.getTvGenres {
                APIHandler.shared.getAllMoviesOnTV {
                    self.mainTableView.reloadData()
                }
            }
        }
        
        
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var counter = 0
        if !APIHandler.shared.moviesInTheater.isEmpty {
            counter += 1
        }
        if !APIHandler.shared.moviesOnTV.isEmpty {
            counter += 1
        }
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
      let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainPageTableViewCell
        
        switch indexPath.row {

        case 0:
                let firstPoster = URL(string: "\(APIHandler.shared.image300Url)\(APIHandler.shared.moviesInTheater [0].posterPath)")
                let secondPoster = URL(string: "\(APIHandler.shared.image300Url)\(APIHandler.shared.moviesInTheater [1].posterPath)")
                cell.cellTitleLabel.text = "In Theaters"
                cell.nowPlayingMoviesTitlesLabel.text = "\(APIHandler.shared.moviesInTheater [0].title), \(APIHandler.shared.moviesInTheater [1].title) and more.."
                cell.nowPlayingMoviesCountLabel.text = "\(APIHandler.shared.moviesInTheater.count) movies in theaters today"
                cell.firstMoviePosterImageView.imageUrl = firstPoster!
                cell.secondMoviePosterImageView.imageUrl = secondPoster!
          
        
        
            
        case 1:
        let firstPoster = URL(string: "\(APIHandler.shared.image300Url)\(APIHandler.shared.moviesOnTV [0].posterPath)")
        let secondPoster = URL(string: "\(APIHandler.shared.image300Url)\(APIHandler.shared.moviesOnTV [1].posterPath)")
        cell.cellTitleLabel.text = "On TV"
        cell.nowPlayingMoviesTitlesLabel.text = "\(APIHandler.shared.moviesOnTV [0].title), \(APIHandler.shared.moviesOnTV [1].title) and more.."
        cell.nowPlayingMoviesCountLabel.text = "\(APIHandler.shared.moviesOnTV.count) movies in theaters today"
        cell.firstMoviePosterImageView.imageUrl = firstPoster!
        cell.secondMoviePosterImageView.imageUrl = secondPoster!
        
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "inTheatersControllerSegue", sender: nil)
        case 1:
            performSegue(withIdentifier: "onTVControllerSegue", sender: nil)
        default:
            return
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch mainTableView.indexPathForSelectedRow!.row {
        case 0:
            if let moviesInTheaterViewController = segue.destination as? MoviesInTheaterListViewController{
                moviesInTheaterViewController.moviesInTheater = APIHandler.shared.moviesInTheater as! [MovieInTheater]
            }
            
        case 1:
            if let onTvViewController = segue.destination as? OnTvViewController{
                onTvViewController.moviesOnTv = APIHandler.shared.moviesOnTV as! [MovieOnTV]
            }
        default:
            return
        }
    
   
}
 }
