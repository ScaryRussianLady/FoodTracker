//
//  Meal.swift
//  FoodTracker
//
//  Created by Annija Balode on 02/07/2018.
//  Copyright © 2018 Annija Balode. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding
    
{
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var ingredients: String?
    
    
    //MARK: Archiving Parts
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    
    
    
    
    //MARK: Types
    
    struct PropertyKey
    {
        //'static' indicates that the constants belong to the structure itself, not to instances
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let ingredients = "ingredients"
    }
    
    
    
    
    
    //MARK: Initialisation
    
    init?(name: String, photo: UIImage?, rating: Int, ingredients: String?)
    {
        
        //a 'guard' statement declares a condition that must be true in order for the code to be executed
        
       //The name must not be empty
        guard !name.isEmpty else
        {
            return nil
        }
        
        //The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else
        {
            return nil
        }
        
        //Initialise stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        self.ingredients = ingredients
        
    }
    
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey:PropertyKey.rating)
        aCoder.encode(ingredients, forKey:PropertyKey.ingredients)
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        //The name is required. If cannot decode a name string, the initialiser should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else
        {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        //Because photo is an optional property of Meal, just use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating  = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        let ingredients = aDecoder.decodeObject(forKey: PropertyKey.ingredients) as? String
        //Must call designated initialiser
        self.init(name: name, photo: photo, rating: rating, ingredients: ingredients)
    }
}
