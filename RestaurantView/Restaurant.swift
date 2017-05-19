//
//  Restaurant.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 5/17/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit

class Restaurant {
    var name: String
    var photo: UIImage?
    var rating: Int
    var price: Int
    var placeID: String
    var address: String
    var phone: String?
    var website: String?
    
    
    init?(name: String, photo: UIImage?, rating: Int, placeID: String) {
        
        if name.isEmpty || rating < 0 || placeID.isEmpty {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
        self.price = 0
        self.placeID = placeID
        self.address = ""
        self.phone = ""
        self.website = ""
    }
    
    init?(name: String, photo: UIImage?, rating: Int, price: Int, placeID: String, address: String, phone: String, website: String) {
        if name.isEmpty || rating < 0 || price < 0 || placeID.isEmpty || address.isEmpty{
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
        self.price = price
        self.placeID = placeID
        self.address = address
        self.phone = phone
        self.website = website
    }
}
