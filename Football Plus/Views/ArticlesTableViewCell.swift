//
//  ArticlesTableViewCell.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 06.12.2020.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var articleInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
