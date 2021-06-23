//
//  ArticlesViewController.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 06.12.2020.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var bottomNavBarImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let jsonManager = JSONManager()
    var articleArray: [[String]] = []
    var articleIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBG(bottomNavBarImage)

        if let array = jsonManager.getData(forName: "articles") {
            articleArray = array
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

}


//MARK: - UICollectionViewDataSource

extension ArticlesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrototypeCell", for: indexPath) as! CollectionViewCell
        cell.containerView.layer.cornerRadius = 5
        cell.cellImage.layer.cornerRadius = 5
        cell.containerForImage.layer.cornerRadius = 5
        CacheManager.setImage(urlString: articleArray[indexPath.row][0], imageView: cell.cellImage)
        cell.cellTitle.text = articleArray[indexPath.row][1]
        cell.cellSubtitle.text = articleArray[indexPath.row][2]
        return cell
    }

}

//MARK: - UICollectionViewDelegate

extension ArticlesViewController: UICollectionViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articlesToArticleInfo" {
            let destinationVC = segue.destination as! ArticleInfoViewController
            if let index = articleIndex {
                destinationVC.articleImage = articleArray[index][0]
                destinationVC.articleName = articleArray[index][1]
                destinationVC.articleDate = articleArray[index][2]
                destinationVC.articleInfo = articleArray[index][3]
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        articleIndex = indexPath[1]
        performSegue(withIdentifier: "articlesToArticleInfo", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let lastIndexPath = collectionView.indexPathsForVisibleItems.last{
            if lastIndexPath.row <= indexPath.row{
                cell.center.y = cell.center.y + cell.frame.height / 2
                cell.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                    cell.center.y = cell.center.y - cell.frame.height / 2
                    cell.alpha = 1
                }, completion: nil)
            }
        }
    }
    
}
