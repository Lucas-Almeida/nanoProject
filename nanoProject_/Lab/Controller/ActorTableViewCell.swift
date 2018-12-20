//
//  ActorTableViewCell.swift
//  Lab
//
//  Created by Ana Freitas Sampaio on 12/17/18.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import UIKit

class ActorTableViewCell: UITableViewCell {

    @IBOutlet weak var actorPicture: UIImageView!
    
    @IBOutlet weak var actorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
