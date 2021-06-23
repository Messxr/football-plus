//
//  ArticleInfoViewController.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 06.12.2020.
//

import UIKit

class ArticleInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomNavBarImage: UIImageView!
    
    var articleImage: String?
    var articleName: String?
    var articleDate: String?
    var articleInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBG(bottomNavBarImage)

        tableView.dataSource = self
    }

}


//MARK: - UITableViewDataSource

extension ArticleInfoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell", for: indexPath) as! ArticlesTableViewCell
        cell.backgroundColor = .clear
        if let image = articleImage, let name = articleName {
            CacheManager.setImage(urlString: image, imageView: cell.articleImage)
            cell.articleName.text = name
            cell.articleInfo.text = articleInfo
        }
        return cell
    }

}
