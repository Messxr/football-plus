//
//  PlayerInfoViewController.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 06.12.2020.
//

import UIKit

class PlayerInfoViewController: UIViewController {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerTextView: UITextView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var bottomNavBarImage: UIImageView!
    
    var playerImage: String?
    var playerName: String?
    var playerInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBG(bottomNavBarImage)

        playerImageView.layer.cornerRadius = 5
        
        if let image = playerImage, let name = playerName, let info = playerInfo {
            CacheManager.setImage(urlString: image, imageView: playerImageView)
            playerTextView.text = info
            playerNameLabel.text = name
        }
        
    }

}
