//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Annija Balode on 02/07/2018.
//  Copyright © 2018 Annija Balode. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    

    //MARK: Meal Class Tests
    
    //Confirm that the Meal initialiser returns a Meal object when passed valid parameters
    func testMealInitialisationSucceeds()
    {
        //Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //Highest positive rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
        
        //Lowest positive rating
        let lowpositiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 1)
        XCTAssertNotNil(lowpositiveRatingMeal)
    }
    
    //Confirm that the Meal initialiser returns nil when passed a negative rating or an empty name
    func testMealInitialisationFails()
    {
        //Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        //Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        //Empty string
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        //If the initialiser is working as expected the calls to  init should fail
        // XCTAssertNil verifies this by checking that the returned Meal object is nil
    }
}
