//
//  RestaurantViewController.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 5/17/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit

var placeIDToPass = ""
let apiKey = "AIzaSyBGV7tQ2_yyymQsRHJad9ZXz9KppR_27Co"


class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var rests1 = [Restaurant]()
    
    @IBOutlet weak var restTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        requestData("restaurants+in+Garden+Grove+CA+92840")
        requestData("33.751696","-117.955846")
//        requestAPIByQuery("restaurants+in+Garden+Grove+CA+92840")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rests1.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
        let cellIdentifier = "RestaurantTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantableViewCell else {
            fatalError("dequeue error")
        }
        let rest = rests1[indexPath.row]
        cell.restName.text = rest.name
        cell.restImg.image = rest.photo
        cell.restRate.rating = rest.rating
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        placeIDToPass = rests1[indexPath.row].placeID
        performSegue(withIdentifier: "segue1", sender: self)
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
                            
                            self.restTableView.reloadData()
                            
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
    
//    func requestData(_ query:String)
//    {
//        let urlTemplate = "https://maps.googleapis.com/maps/api/place/textsearch/json?query="+query+"&key="+apiKey
//        if let url = NSURL(string: urlTemplate) {
//            let request = NSURLRequest(url: url as URL)
//            let session = URLSession.shared
//            session.dataTask(with: request as URLRequest) { (data, response, error) in
//                if (error == nil) {
//                    do {
//                        let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
//                        let results = parsedData["results"] as! [[String:Any]]
//                        
//                        var i:Int = 1;
//                        for result in results {
//                            let name = result["name"] as! String
//                            let placeID = result["place_id"] as! String
//                            let address = result["formatted_address"] as! String
//                            let rate = result["rating"] as! Float
//                            
//                            print(String(i)+". "+name)
//                            print(address)
//                            print("Rate: "+String(rate))
//                            
//                            let defaultphoto = UIImage(named: "defaultRestaurant")
//                            guard let rest = Restaurant(name: name, photo: defaultphoto, rating: Int(rate), placeID: placeID) else {
//                                fatalError("Cannot instantiate")
//                            }
//                            self.rests1.append(rest)
//                            
//                            self.restTableView.reloadData()
//                            
//                            print()
//                            i+=1
//                        }
//                        
//                    } catch let error as NSError {
//                        print(error)
//                    }
//                } else {
//                    print(error!)
//                }
//            }.resume()
//        }
//        
//    }
    
//    func requestAPIByQuery(_ query:String) {
//        let urlTemplate = "https://maps.googleapis.com/maps/api/place/textsearch/json?query="+query+"&key="+apiKey
//        let url:NSURL = NSURL(string: urlTemplate)!
//        let session = URLSession.shared
//        
//        let request = NSMutableURLRequest(url: url as URL)
//        
//        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
//            
//            if error != nil {
//                print(error!)
//            } else {
//                do {
//                    
//                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
//                    let results = parsedData["results"] as! [[String:Any]]
//                    
//                    var i:Int = 1;
//                    for result in results {
//                        let name = result["name"] as! String
//                        self.rests.append(name)
//                        
//                        self.restTableView.reloadData()
//                        
//                        let address = result["formatted_address"] as! String
//                        let rate = result["rating"] as! Float
//                        print(String(i)+". "+name)
//                        print(address)
//                        print("Rate: "+String(rate))
//                        
//                        print()
//                        i+=1
//                    }
//                    
//                } catch let error as NSError {
//                    print(error)
//                }
//            }
//        }
//        
//        task.resume()
//        
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
