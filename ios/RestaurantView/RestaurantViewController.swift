//
//  ViewController.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 5/17/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit

//var dishes = ["pho", "mi", "com tam"]
//var myIndex = 0
//var dishesDesc = ["rice noodles","egg noodles","broken rice"]


var dishToPass = Dish()
var cats = ["Starter", "Entree", "Side", "Desert"]

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var dishes1 = [Dish]()
    
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
                    
                        let name = result["name"] as! String
                        let imageURL = result["image_url"] as! String
                        if let url = URL(string: imageURL) {
                            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                                if let data = data {
                                    let photo = UIImage(data: data)
                                    let rest = Restaurant(name: name, photo: photo!, rating: Int(rate), price: Int(price), placeID: placeID, address: address, phone: phone!, website: website!)
                                    self.restName.text = rest?.name
                                    self.restImg.image = rest?.photo
                                    self.restRate.text = "Rate: \(rest?.rating ?? 0)"
                                    self.restPrice.text = "Price: \(rest?.price ?? 0)"
                                    self.restAddr.text = rest?.address
                                    self.restPhone.text = rest?.phone
                                    self.restWeb.text = rest?.website
                                }
                            })
                            task.resume()
                        } else {
                            let photo = UIImage(named: "defaultRestaurant")!
                            let rest = Restaurant(name: name, photo: photo , rating: Int(rate), price: Int(price), placeID: placeID, address: address, phone: phone!, website: website!)
                            self.restName.text = rest?.name
                            self.restImg.image = rest?.photo
                            self.restRate.text = "Rate: \(rest?.rating ?? 0)"
                            self.restPrice.text = "Price: \(rest?.price ?? 0)"
                            self.restAddr.text = rest?.address
                            self.restPhone.text = rest?.phone
                            self.restWeb.text = rest?.website
                        }
                        let dishesList = result["dishes"] as! [[String:Any]]
                        print(dishesList)
                        for item in dishesList {
                            let dname = item["dish"] as! String
                            let dprice = item["price"] as! Float
                            let dcategory = "Starter"
                            let dphoto = UIImage(named: "defaultRestaurant")
                            let drate = item["rating"] as! Float
                            let ddescription = item["description"] as! String
                            
                            guard let d = Dish(name: dname, price: dprice, category: dcategory, photo: dphoto, rating: Int(drate), description: ddescription) else {
                                fatalError("Cannot instantiate")
                            }
                            self.dishes1.append(d)
                            
                            self.menuTableView.reloadData()
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
        let cellIdentifier = "cell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MenuTableViewCell else {
            fatalError("dequeue error")
        }
        let d = dishes1[indexPath.row]
        cell.dishName.text = d.name
        cell.dishRate.rating = d.rating
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        myIndex = indexPath.row
        dishToPass = dishes1[indexPath.row]
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

