//
//  NewsArticleCell.swift
//  news-app
//
//  Created by Alex Mosunov on 05.09.2020.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit

class NewsArticleCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var soucreLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func readMoreButtonTapped(_ sender: UIButton) {
    }
    
    

}
