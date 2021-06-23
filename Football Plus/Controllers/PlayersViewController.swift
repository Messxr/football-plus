//
//  PlayersViewController.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 06.12.2020.
//

import UIKit

class PlayersViewController: UIViewController {
    
    @IBOutlet weak var bottomNavBarImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let jsonManager = JSONManager()
    var playerArray: [[String]] = []
    var playerIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBG(bottomNavBarImage)

        if let array = jsonManager.getData(forName: "players") {
            playerArray = array
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

}


//MARK: - UICollectionViewDataSource

extension PlayersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrototypeCell", for: indexPath) as! CollectionViewCell
        cell.containerView.layer.cornerRadius = 5
        cell.cellImage.layer.cornerRadius = 5
        cell.containerForImage.layer.cornerRadius = 5
        cell.cellTitle.text = playerArray[indexPath.row][1]
        CacheManager.setImage(urlString: playerArray[indexPath.row][0], imageView: cell.cellImage)
        cell.cellSubtitle.text = playerArray[indexPath.row][2]
        return cell
    }

}

//MARK: - UICollectionViewDelegate

extension PlayersViewController: UICollectionViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playersToPlayerInfo" {
            let destinationVC = segue.destination as! PlayerInfoViewController
            if let index = playerIndex {
                destinationVC.playerImage = playerArray[index][0]
                destinationVC.playerName = playerArray[index][1]
                destinationVC.playerInfo = playerArray[index][3]
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playerIndex = indexPath[1]
        performSegue(withIdentifier: "playersToPlayerInfo", sender: self)
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

