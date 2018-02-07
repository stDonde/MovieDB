//
//  TVandMovieTabsViewController.swift
//  MovieDB
//
//  Created by Esther Donde on 06/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit


class TVandMovieTabsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarControllerDelegate {
    
    @IBOutlet weak var mainCollectionVIew: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIHandler.shared.getTvGenres {
        APIHandler.shared.getPopularMoviesOnTV {
            self.mainCollectionVIew.reloadData()
            }}
        APIHandler.shared.getInTheatersGenres {
            
            APIHandler.shared.getPopularMoviesInTheaters {
                self.mainCollectionVIew.reloadData()
            }
        }
        
        }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItems : Int?
        if tabBarController?.tabBar.selectedItem?.tag == 2 {
            title = "Movies"
            numberOfItems = APIHandler.shared.popularInTheaters.count
        }else if tabBarController?.tabBar.selectedItem?.tag == 3 {
            title = "TV"
            numberOfItems = APIHandler.shared.popularTV.count
            
        }
        return numberOfItems!
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! TVandMovieTabsCollectionViewCell
        if tabBarController?.tabBar.selectedItem?.tag == 2 {
            let movie = APIHandler.shared.popularInTheaters[indexPath.row]
            let posterURL = URL (string: "\(APIHandler.shared.image300Url)" + movie.posterPath)
            cell.titleLabel.text = movie.title
            cell.posterImageView.imageUrl = posterURL!
        } else if tabBarController?.tabBar.selectedItem?.tag == 3 {
            
            let movie = APIHandler.shared.popularTV[indexPath.row]
            let posterURL = URL (string: "\(APIHandler.shared.image300Url)" + movie.posterPath)
            cell.titleLabel.text = movie.title
            cell.posterImageView.imageUrl = posterURL!
        }
        
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if tabBarController?.tabBar.selectedItem?.tag == 2 {
            performSegue(withIdentifier: "inTheaters", sender: nil)
        } else if tabBarController?.tabBar.selectedItem?.tag == 3 {
            performSegue(withIdentifier: "tv", sender: nil)
        }
        }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tv" {
            if let detailedViewController = segue.destination as? OnTvDetailedViewController {
                detailedViewController.movie = APIHandler.shared.popularTV[(mainCollectionVIew.indexPathsForSelectedItems?.first?.row)!] as! MovieOnTV
            }}
            if segue.identifier == "inTheaters" {
                if let inTheatersDetailedViewController = segue.destination as? InTheatersDetailedViewController {
                    inTheatersDetailedViewController.movie = APIHandler.shared.popularInTheaters[(mainCollectionVIew.indexPathsForSelectedItems?.first?.row)!] as! MovieInTheater
                }
        }

}
}

