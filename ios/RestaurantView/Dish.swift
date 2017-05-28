//
//  Dish.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 5/18/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit

class Dish {
    var name: String
    var price: Float
    var category: String
    var photo: UIImage?
    var rating: Int
    var description: String?
    
    init?() {
        self.name = ""
        self.price = 0
        self.category = ""
        self.photo = nil
        self.rating = 0
        self.description = ""
    }
    
    init?(name: String, price: Float, category: String, photo: UIImage?, rating: Int, description: String?) {
        
        if name.isEmpty || price < 0 || rating < 0 || category.isEmpty{
            return nil
        }
        
        self.name = name
        self.price = price
        self.category = category
        self.photo = photo
        self.rating = rating
        self.description = description
    }
}
