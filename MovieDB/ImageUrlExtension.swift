//
//  ImageUrlExtension.swift
//  MovieDB
//
//  Created by Esther Donde on 01/12/2017.
//  Copyright © 2017 Esther Donde. All rights reserved.
//

import UIKit


extension UIImageView {
    
    var imageUrl : URL {
        set{
            URLSession.shared.dataTask(with: newValue) { (data, response, error) in
                if let data = data{
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
                }.resume()
        }
        
        get{
            return URL(string:"http://www.a.com")!
        }
    }
}
