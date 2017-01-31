//
//  ViewController.swift
//  API_Demo
//
//  Created by Ahmed T Khalil on 1/25/17.
//  Copyright © 2017 kalikans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to retrieve JSON data from API, simply download web data as usual
        //difference is that you need an API key for the URL request to go through
        let openWeatherMapAPIKey = "93f99b0b453ef97c0c2595c93c09f816"
        let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=\(openWeatherMapAPIKey)"
        
        if let weatherURL = URL(string: urlStr){
            let request = URLRequest(url: weatherURL)
            
            let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                
                if error != nil{
                    
                    print(error as Any)
                    
                }else{
                    //now you have JSON data in 'data'
                    if let dataUnwrapped = data {
                        //convert JSON to usable format
                        do{
                            let JSONResults = try JSONSerialization.jsonObject(with: dataUnwrapped, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            //NOTE: '{' in printed JSON results dictionary syntax and '(' is array syntax
                            //So if you look at print(JSONResults) in output you'll see that JSONResults is one big dictionary where all entries are optionals
                            print(JSONResults)
                            
                            //so to access the name variable, use 'name' as dictionary key
                            if let name = JSONResults["name"] as? String{
                                print(name)
                            }
                            
                            //and to access description
                            //search 'Optional Chaining' if you don't recall (http://rshankar.com/optional-bindings-in-swift/)
                            //Basic Idea: if you don't know if something exists and you're requesting an index from it, use '?' before index
                            if let weatherDesc = ((JSONResults["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                print(weatherDesc)
                            }
                            
                        } catch {
                            
                            print("JSON Processing Failed")
                            
                        }
                    }
                }
            }
            task.resume()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

