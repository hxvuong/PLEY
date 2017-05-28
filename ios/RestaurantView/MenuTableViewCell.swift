//
//  MenuTableViewCell.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 5/28/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishImg: UIImageView!
    @IBOutlet weak var dishRate: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
