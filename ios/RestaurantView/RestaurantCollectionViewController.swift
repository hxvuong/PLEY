//
//  RestaurantCollectionViewController.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 6/12/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit
var placeIDToPass = ""
class RestaurantCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var name = String()
    var location = String()
    var rests1 = [Restaurant]()
    
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restaurantCollectionView.delegate = self
        self.restaurantCollectionView.dataSource = self
        
        requestData(name, location)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rests1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restCollectionViewCell", for: indexPath) as! RestaurantCollectionViewCell

        let rest = rests1[indexPath.row]
        cell.restName.text = rest.name
        cell.restImage.image = rest.photo
        cell.restRate.text = String(rest.rating)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        placeIDToPass = rests1[indexPath.row].placeID
        performSegue(withIdentifier: "segue123", sender: self)
    }
    
    func requestData(_ lat:String, _ long:String)
    {
        let urlTemplate = "http://54.241.187.189:8080/PLEY_TEST/GetNearbyRestaurants?latitude="+lat+"&longitude="+long
        if let url = NSURL(string: urlTemplate) {
            let request = NSURLRequest(url: url as URL)
            let session = URLSession.shared
            session.dataTask(with: request as URLRequest) { (data, response, error) in
                if (error == nil) {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
                        var i:Int = 1;
                        for result in parsedData {
                            let name = result["name"] as! String
                            let jrate = result["rating"] as? String
                            var rate : Float = 0.0
                            if (jrate != nil) {
                                rate = Float(jrate!)!
                            }
                            let placeID = result["place_id"] as! String
                            
                            
                            print(String(i)+". "+name)
                            print(placeID)
                            
                            
                            let defaultphoto = UIImage(named: "defaultRestaurant")
                            guard let rest = Restaurant(name: name, photo: defaultphoto, rating: Int(rate), placeID: placeID) else {
                                fatalError("Cannot instantiate")
                            }
                            self.rests1.append(rest)
                            self.restaurantCollectionView.reloadData()
                            print()
                            i+=1
                        }
                        
                    } catch let error as NSError {
                        print(error)
                    }
                } else {
                    print(error!)
                }
                }.resume()
        }
        
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
