//
//  DishViewController.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 5/17/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit

class DishViewController: UIViewController {

    @IBOutlet weak var dishTitle: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishDesc: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dishTitle.text = dishes[myIndex]
        dishImage.image = UIImage(named: dishes[myIndex] + ".jpg")
        dishDesc.text = dishesDesc[myIndex]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
