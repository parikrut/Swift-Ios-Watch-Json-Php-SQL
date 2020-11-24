//
//  CarObject.swift
//  Json-WatchApp
//
//  Created by Xcode User on 2020-11-23.
//

import UIKit

class CarObject: NSObject ,NSCoding{
    var Model : String?
    var Make : String?
    var Year : String?
    var Color : String?
    var NewOrused : String?
    var Price : String?

    
    func initWithData( Model:String,
                       Make:String,
                       Year:String,
                       Color:String,
                       NewOrused:String,
                       Price : String)
    {
        
        self.Model = Model
        self.Make = Make
        self.Year = Year
        self.Color = Color
        self.NewOrused = NewOrused
        self.Price = Price
    }
    
    // step 3c -> create these two methods Color handle serialization of data between
    // phone and watch.
    required convenience init?(coder decoder: NSCoder) {
        
        guard let Model = decoder.decodeObject(forKey: "Model") as? String,
            let Make = decoder.decodeObject(forKey: "Make") as? String,
            let Year = decoder.decodeObject(forKey: "Year") as? String,
            let Color = decoder.decodeObject(forKey: "Color") as? String,
            let NewOrused = decoder.decodeObject(forKey: "NewOrused") as? String,
            let Price = decoder.decodeObject(forKey: "Price") as? String

            else { return nil }
        
        
        // note this will cause crash if its not in here exactly as is
        self.init()
        self.initWithData(
            Model: Model as String,
            Make: Make as String,
            Year : Year as String,
            Color : Color as String,
            NewOrused : NewOrused as String,
            Price: Price as String
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.Model, forKey: "Model")
        coder.encode(self.Make, forKey: "Make")
        coder.encode(self.Year, forKey: "Year")
        coder.encode(self.Color, forKey: "Color")
        coder.encode(self.NewOrused, forKey: "NewOrused")
        coder.encode(self.Price, forKey: "Price")

        
    }
}

