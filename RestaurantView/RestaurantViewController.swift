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
        let urlTemplate = "https://maps.googleapis.com/maps/api/place/details/json?placeid="+placeid+"&key="+apiKey
        if let url = NSURL(string: urlTemplate) {
            let request = NSURLRequest(url: url as URL)
            let session = URLSession.shared
            session.dataTask(with: request as URLRequest) { (data, response, error) in
                if (error == nil) {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                        let result = parsedData["result"] as! [String:Any]
                        
                        print(result)
                        
                        
                        let name = result["name"] as! String
                        let defaultphoto = UIImage(named: "defaultRestaurant")
//                        let jrate = result["rating"] as? String
//                        var rate : Float = 0.0
//                        if (jrate != nil) {
//                            rate = Float(jrate!)!
//                        }
//                        let jprice = result["price_level"] as? String
//                        var price : Float = 0.0
//                        if (jprice != nil) {
//                            price = Float(jprice!)!
//                        }

                        let rate = result["rating"] as? Float ?? 0
                        let price = result["price_level"] as? Float ?? 0
                        let placeID = placeIDToPass
                        let address = result["formatted_address"] as! String
                        let phone = result["formatted_phone_number"] as? String
                        let website = result["website"] as? String
                        
                        let rest = Restaurant(name: name, photo: defaultphoto, rating: Int(rate), price: Int(price), placeID: placeID, address: address, phone: phone!, website: website!)
                        
                        self.restName.text = rest?.name
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

