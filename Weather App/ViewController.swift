//
//  ViewController.swift
//  Weather App
//
//  Created by j Wang on 9/5/16.
//  Copyright © 2016 jonwang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet var cityEntered: UITextField!
  
  @IBOutlet var weatherOutput: UILabel!
  
  @IBAction func submit(_ sender: AnyObject) {
    
//    Convert entered text to NSString and make it one word
    
    var cityString = ""
    
    if let cityObject = cityEntered.text {
      
      let city = NSString(string: String(cityObject))
      
      city.replacingOccurrences(of: " ", with: "")
      
      cityString = city as String
      
      print(cityString)
      
    }
    
    
//    Grab and download data from URL
    
    if let url = URL(string: "http://www.weather-forecast.com/locations/\(cityString)") {
      
      let request = URLRequest(url: url)
      
      let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        
        if error != nil {
          
          DispatchQueue.main.sync {
          self.weatherOutput.text = "Error: Please enter a valid city"
          }
          
        } else {
          
          if let unwrappedData = data {
            
            let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
            
            print(dataString)
            
          }
          
        }
      }
      task.resume()
    }
    cityEntered.text = ""
  }


  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    
    return true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    view.self.endEditing(true)
  }
  
  

}

