//
//  InformationViewController.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 09.10.2020.
//

import UIKit

class TeamInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomNavBarImage: UIImageView!
    
    var teamSchedule: [[String]] = [[],[]]
    var teamName: String?
    var teamAbout: String?
    var teamImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBG(bottomNavBarImage)
        
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
    }

}


//MARK: - UITableViewDataSource

extension TeamInfoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamSchedule[0].count + 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! HeaderTeamCell
            cell.backgroundColor = .clear
            if let name = teamName, let image = teamImage {
                cell.teamName.text = name
                cell.teamImage.image = UIImage(named: image)
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Team", for: indexPath) as! AboutTeamCell
            cell.teamInfo.text = teamAbout
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Top", for: indexPath) as! TopScheduleCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Middle", for: indexPath) as! MiddleScheduleCell
            cell.dateLabel.text = teamSchedule[0][indexPath.row - 3]
            cell.teamsLabel.text = teamSchedule[1][indexPath.row - 3]
            return cell
        }
    }

}
