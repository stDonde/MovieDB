//
//  InTheatersDetailedViewController.swift
//  MovieDB
//
//  Created by Esther Donde on 12/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit

class InTheatersDetailedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var detailedTableView: UITableView!
    var movie : MovieInTheater!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            title = movie.title
        APIHandler.shared.getRunTime(forMovie: movie) {
            self.detailedTableView.reloadData()}
        
            APIHandler.shared.getVideos(forMovie: movie) {
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
        if !movie.videos.isEmpty {
            return movie.videos.count }
        else {
            return 1
        }
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row == 0{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "detailedCell") as! CustomTableViewCell
            let poster = URL(string: "\(APIHandler.shared.image300Url)\(movie.posterPath)")
            
            if let poster = poster {
                cell1.moviePosterImageView.imageUrl = poster }
            cell1.votePic.image = #imageLiteral(resourceName: "yellow-star")
            cell1.movieTitleLabel.text = movie.title
            cell1.genresLabel.text = dump(movie.genres?.joined(separator: ", "))
            cell1.overviewTextField.text = movie.overview
            cell1.releaseDateLabel.text = movie.releaseDate
            if let runTime = movie.runTime {
                cell1.runTimeLabel.text = "\(runTime) min" }
            return cell1
        }
            else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "videoCell")!
            if !movie.videos.isEmpty {
                cell2.textLabel?.text = movie.videos[indexPath.row].type }
            return cell2
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let videoViewController = segue.destination as? VideosViewController {
            videoViewController.video = movie.videos [detailedTableView.indexPathForSelectedRow!.row]
        }
    }
    
    


}
