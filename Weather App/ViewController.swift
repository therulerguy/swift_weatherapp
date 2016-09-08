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
  
  var message = ""
  
  @IBAction func submit(_ sender: AnyObject) {
    
//    Converting user entered text into one word
    
    var cityString = ""
    
    if let cityObject = cityEntered.text {
      
      let city = NSString(string: cityObject)
      
      cityString = city.replacingOccurrences(of: " ", with: "")
    }
    
//    Grabbing the data from the webpage and displaying HTML to the console
    
    if let url = URL(string: "http://weather-forecast.com/locations/\(cityString)/forecasts/latest") {
    
    let request = NSMutableURLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
      data, response, error in
      
      if error != nil {
        
        self.weatherOutput.text = "Please enter a valid city"
        
      } else {
        
        if let unwrappedData = data {
          
          let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
          
          var stringSeperator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
          
          if let contentArray = dataString?.components(separatedBy: stringSeperator) {
            
            if contentArray.count > 1 {
              
              stringSeperator = "</span>"
              
              let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
              
              if newContentArray.count > 1 {
                
                self.message = newContentArray[0]
  
              DispatchQueue.main.sync(execute: {
                
                self.weatherOutput.text = newContentArray[0].replacingOccurrences(of: "&deg;", with: "˚")

              })
              }
            }
          }
        }
      }
      
      DispatchQueue.main.sync(execute: {
      
      if self.message == "" {
        
        self.weatherOutput.text = "The weather there couldn't be found. Please try again"
        
      }
        })
      
    }
    
    task.resume()
      
    } else {
      
      self.weatherOutput.text = "The weather there couldn't be found. Please try again"
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

