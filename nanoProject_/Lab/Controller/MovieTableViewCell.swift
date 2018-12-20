
//
//  MovieTableViewCell.swift
//  Lab
//
//  Created by Lucas Almeida on 18/12/18.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
