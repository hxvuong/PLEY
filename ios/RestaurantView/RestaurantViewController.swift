//
//  ViewController.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 5/17/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit

var dishes = ["pho", "mi", "com tam"]
var myIndex = 0
var dishesDesc = ["rice noodles","egg noodles","broken rice"]

var cats = ["Starter", "Entree", "Side", "Desert"]

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var catTextBox: UITextField!
    @IBOutlet weak var catPicker: UIPickerView!
    
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restRate: UILabel!
    @IBOutlet weak var restPrice: UILabel!
    @IBOutlet weak var restAddr: UILabel!
    @IBOutlet weak var restPhone: UILabel!
    @IBOutlet weak var restWeb: UILabel!
    @IBOutlet weak var restImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaceByPlaceID(placeIDToPass)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getPlaceByPlaceID(_ placeid:String)
    {
        let urlTemplate = "http://54.241.187.189:8080/PLEY_TEST/GetRestaurantByPlaceId?place_id="+placeIDToPass
        if let url = NSURL(string: urlTemplate) {
            let request = NSURLRequest(url: url as URL)
            let session = URLSession.shared
            session.dataTask(with: request as URLRequest) { (data, response, error) in
                if (error == nil) {
                    do {
                        let result = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
//                        let result = parsedData["result"] as! [String:Any]
                        
//                        print(result)
                        
                        
                        let name = result["name"] as! String
                        
//                        let imageURL = result["image_url"] as? String
                        let imageURL = "https://s-media-cache-ak0.pinimg.com/originals/8b/19/f7/8b19f7147ba13841903b1e9d28f2d058.jpg"
                        

//                        if imageURL != nil {
//                            if let url = URL(string: imageURL) {
//                                let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
//                                    if let data = data {
//                                        photo = UIImage(data: data)!
//                                        self.restImg.image = UIImage(data: data)
//                                    }
//                                })
//                                task.resume()
//                            }
//                        } else {
//                            photo = UIImage(named: "defaultRestaurant")!
//                        }
                        var photo = UIImage(named: "defaultRestaurant")!
                        if let url = URL(string: imageURL) {
                            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                                if let data = data {
                                    let photo1 = UIImage(data: data)
                                    photo = copy(photo1)
                                }
                            })
                            task.resume()
                        }
                        
                        let jrate = result["rating"] as? String
                        
                        var rate : Float = 0.0
                        if (jrate != nil) {
                            rate = Float(jrate!)!
                        }
                        

                        let price = result["price_level"] as! Float
                        let placeID = placeIDToPass
                        let address = result["address"] as! String
                        let phone = result["phone"] as? String
                        
                        var website = result["website"] as? String
                        if website == nil {
                            website = "No Data"
                        }
                    
                        
                        let rest = Restaurant(name: name, photo: photo as! UIImage, rating: Int(rate), price: Int(price), placeID: placeID, address: address, phone: phone!, website: website!)
                        
                        self.restName.text = rest?.name
                        self.restImg.image = rest?.photo
                        self.restRate.text = "Rate: \(rest?.rating ?? 0)"
                        self.restPrice.text = "Price: \(rest?.price ?? 0)"
                        self.restAddr.text = rest?.address
                        self.restPhone.text = rest?.phone
                        self.restWeb.text = rest?.website
                        
//                        self.restName.text = result["name"] as? String
//                        let rate = result["rating"] as? Float
//                        self.restRate.text = "Rate: \(rate ?? 0)"
//                        let price = result["price_level"] as? Float
//                        self.restPrice.text = "Price: \(price ?? 0)"
//                        self.restAddr.text = result["formatted_address"] as? String
//                        self.restPhone.text = result["formatted_phone_number"] as? String
//                        self.restWeb.text = result["website"] as? String

                        
                    } catch let error as NSError {
                        print(error)
                    }
                } else {
                    print(error!)
                }
                }.resume()
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dishes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cats.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cats[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        catTextBox.text = cats[row]
        catPicker.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        catPicker.isHidden = false
    }
    
}

