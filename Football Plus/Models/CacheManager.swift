//
//  CasheManager.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 12.08.2020.
//  Copyright © 2020 Daniil Marusenko. All rights reserved.
//

import UIKit

class CacheManager {
    
    private static var cache = [String : Data]()
    
    private static func setCache(_ url: String, _ data: Data?) {
        cache[url] = data
    }
    
    private static func getCache(_ url: String) -> Data? {
        return cache[url]
    }
    
    static func setImage(urlString: String, imageView: UIImageView) {
        if let cachedData = getCache(urlString) {
            imageView.image = UIImage(data: cachedData)
            return
        }
        
        let url = URL(string: urlString)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                setCache(url!.absoluteString, data)
                
                // Create the image object
                let image = UIImage(data: data!)
                
                //Set the ImageView
                DispatchQueue.main.async {
                    imageView.image = image
                }
                
            }
        }
        task.resume()
    }
    
}
