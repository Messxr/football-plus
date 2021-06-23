//
//  ViewController.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 09.10.2020.
//

import UIKit

class TeamsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomNavBarImage: UIImageView!
    
    let jsonManager = JSONManager()
    var teamArray: [[String]] = []
    var teamIndex: Int?
    let transiton = SlideInTransition()
    var topView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        setBG(bottomNavBarImage)
        let attributes = [NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "Scada", size: 20), size: 20)]
        navigationController?.navigationBar.titleTextAttributes = attributes
                
        if let array = jsonManager.getData(forName: "teams") {
            teamArray = array
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

//MARK: - UICollectionViewDataSource

extension TeamsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrototypeCell", for: indexPath) as! CollectionViewCell
        cell.containerView.layer.cornerRadius = 5
        cell.containerForImage.layer.cornerRadius = 5
        cell.cellImage.image = UIImage(named: "\(indexPath.row)")
        cell.cellTitle.text = teamArray[indexPath.row][0]
        cell.cellSubtitle.text = teamArray[indexPath.row][1]
        return cell
    }

}

//MARK: - UICollectionViewDelegate

extension TeamsViewController: UICollectionViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "teamsToTeamInfo" {
            let destinationVC = segue.destination as! TeamInfoViewController
            if let index = teamIndex {
                destinationVC.teamName = teamArray[index][0]
                destinationVC.teamImage = teamArray[index][2]
                destinationVC.teamAbout = teamArray[index][3]
                var counter = 0
                var array: [[String]] = [[],[]]
                for item in teamArray[index] {
                    if counter > 3 && Double(Int(counter/2)) - Double(counter)/2.0 == 0 {
                        array[0].append(item)
                    } else if counter > 3 && Double(Int(counter/2)) - Double(counter)/2.0 != 0 {
                        array[1].append(item)
                    }
                    counter += 1
                }
                destinationVC.teamSchedule = array
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        teamIndex = indexPath[1]
        performSegue(withIdentifier: "teamsToTeamInfo", sender: self)
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

//MARK: - SideMenu

extension TeamsViewController {

    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }

    func transitionToNew(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title

        topView?.removeFromSuperview()
        switch menuType {
        case .teams:
            guard let childVC = self.storyboard?.instantiateViewController(withIdentifier: "Teams") else { return }
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)
            self.title = "Clubs"
        case .players:
            guard let childVC = self.storyboard?.instantiateViewController(withIdentifier: "Players") else { return }
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)
        case .articles:
            guard let childVC = self.storyboard?.instantiateViewController(withIdentifier: "Articles") else { return }
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)
            self.title = "News"
        case .settings:
            guard let childVC = self.storyboard?.instantiateViewController(withIdentifier: "Settings") else { return }
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)
        }
    }

}

//MARK: - UIViewControllerTransitioningDelegate

extension TeamsViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}

//MARK: - extension UIViewController

extension UIViewController {
    
    func setBG(_ view: UIView) {
        let modelName = UIDevice.modelName
        if modelName != "Simulator iPhone 8 Plus" && modelName != "Simulator iPhone 8" && modelName != "iPhone 8 Plus" && modelName != "iPhone 8" {
            let img = UIImage(named: "nb-bg")
            navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        } else {
            view.isHidden = true
        }
    }
    
}

