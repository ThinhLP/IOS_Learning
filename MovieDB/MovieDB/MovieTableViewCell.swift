//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Thinh Le Phuc on 4/11/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var dataSource: Movie? {
        didSet {
            guard let movie = dataSource else {
                return
            }
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            if let data = movie.posterData {
                posterImageView.image = UIImage(data: data)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
