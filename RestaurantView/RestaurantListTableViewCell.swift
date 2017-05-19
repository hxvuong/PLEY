//
//  RestaurantTableViewCell.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 5/17/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restImg: UIImageView!
    @IBOutlet weak var restRate: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
