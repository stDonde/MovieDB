//
//  VideosViewController.swift
//  MovieDB
//
//  Created by Esther Donde on 16/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit
import WebKit
class VideosViewController: UIViewController {
    
    var video : Video!
   
    @IBOutlet weak var videoWebView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let loadVideoURL = URL(string: APIHandler.shared.youtubeURL + self.video.key)
        self.videoWebView.load(URLRequest(url: loadVideoURL!))
        }
    }

    

