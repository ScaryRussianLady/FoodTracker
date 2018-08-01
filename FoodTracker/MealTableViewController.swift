//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Annija Balode on 02/07/2018.
//  Copyright © 2018 Annija Balode. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    
    
    
    //MARK: Properties
    
    var meals = [Meal]() //declares a propery on MealTableViewController and initialises it with a default value. The default value is an empty array of Meal objects
    //making this a variable means that items can be added after initialisating it
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor(red: 160/255, green: 145/255, blue: 255/255, alpha: 1)
        self.view.backgroundColor = UIColor(hue: 0.7778, saturation: 0.15, brightness: 0.92, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = UIColor(hue: 0.7778, saturation: 0.30, brightness: 0.92, alpha: 1)
        
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        reloadTable()
        
        //Use the edit button item provided by the table view controller
        //Creates a type of bar button item that has editing behaviour built into it
        //Then adds this button to the left side of the navigation bar in the meal list scene
//        navigationItem.leftBarButtonItem = editButtonItem
//        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        //Load any saved meals, otherwise load sample data
//        if let savedMeals = loadMeals()
//        {
//            meals = savedMeals.sorted { (meal1, meal2) -> Bool in
//                return meal1.rating > meal2.rating
//            }
//        }
//
//        else
//        {
//            //Load the sample data
//            //            loadSampleMeals()
//        }
//
        //when the view loads the below code calls the method to load the sample data
        //        loadSampleMeals()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        reloadTable()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadTable()
    {
        meals.removeAll()
        
        if let savedMeals = loadMeals()
        {
            meals = savedMeals.sorted { (meal1, meal2) -> Bool in
                return meal1.rating > meal2.rating
            }
        }
        
        tableView.reloadData()
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    //The following functions tells the table view how many sections to display
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //this will make the table view show one section instead of 0
        return 1
    }
    
    //tells the table view how many rows to display in a section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //returns the number of meals you have (returns the number of items in the array)
        return meals.count
    }
    
    //'dequeueReusableCell' method requests a cell from the table view. It tries to reuse the cells when possible instead of creating new cells and deleting old cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //Table view cells are reused and should be dequeued using a cell identifier
        //Creates a constant with the identifier set in the storyboard
        let cellIdentifier = "MealTableViewCell"
        
        //The 'as? MealTableViewCell' expression attempts to downcast the returned object from the UITableViewClass class to the MealTableViewCell class
        //This returns an optional so the 'guard let' expression safely unwraps the optional
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else
        {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        //Fetches the appropriate meal for the data source layout
        let meal = meals[indexPath.row]
        
        //Set each of the views in the table view cell to display the corresponding data from 'meal' object
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    
    
    
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            // Delete the row from the data source
            //Removes the Meal objects to be deleted from meals
            meals.remove(at: indexPath.row)
            
            //Saves the meals array whenever a meal is deleted
            saveMeals()
            
            //Deletes the corresponding row from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
            
//        else if editingStyle == .insert
//        {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//            if let saveMeals = loadMeals()
//            {
//                meals = saveMeals.sorted { (meal1, meal2) -> Bool in
//                    return meal1.rating > meal2.rating
//                }
//            }
//        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
        //A switch statement considers a value and compares it against several possible matching patterns.
        switch(segue.identifier ?? "")
        {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else
            {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            
            guard let selectedMealCell = sender as? MealTableViewCell else
            {
                fatalError("Unexpected sender: \(sender)")
            }
            
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else
            {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue)
    {
        
        
        
        if let sourceViewController = sender.source as?
            MealViewController, let meal = sourceViewController.meal
        {
            //Checks whether a row in the table view is selected
            //This is executed when the user is editing an existing meal
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {
                //Update an existing meal
                //Updates the meals array. Replaces the old meal object with the new, edited meal object
                meals[selectedIndexPath.row] = meal
                //Reloads the appropriate row in the table view
//                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }

                //This gets executed when the user adds a new meal
            else
            {
                //Add a new meal
//                let newIndexPath = IndexPath(row: meals.count, section: 0)

                meals.append(meal)

//                tableView.insertRows(at: [newIndexPath], with: .automatic)


            }

        
            
            //Save the meals
            saveMeals()
            reloadTable()
            
            
            
            
            //            //Add a new meal
            //            //Computes the location in the table view where the new table view cell representing the new meal will be inserted
            //            //Stores it in a local constant called newIndexPath
            //            let newIndexPath = IndexPath(row: meals.count, section: 0)
            //
            //            //Adds the new meal to the existing list of meals in the data model
            //            meals.append(meal)
            //
            //            //Animates the addition of a new row to the table view
            //            //Contains information about the new meal
            //            //'.automatic' uses the best animation based on the table's current state and the insertion point's location
            //            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
        
    }
    
    
    
    
    
    
    //MARK: Private Methods
    //    private func loadSampleMeals() //method to load sample data into the app
    //    {
    //        let photo1 = UIImage(named: "meal1")
    //        let photo2 = UIImage(named: "meal2")
    //        let photo3 = UIImage(named: "meal3")
    //
    //        //This creates 3 meal objects
    //        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else
    //        {
    //            fatalError("Unable to instantiate meal1")
    //        }
    //
    //        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else
    //        {
    //            fatalError("Unable to instantiate meal2")
    //        }
    //
    //        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else
    //        {
    //            fatalError("Unable to instantiate meal3")
    //        }
    //
    //        //Adds the meal objects to the meals array
    //        meals += [meal1, meal2, meal3]
    //
    //
    //    }
    
    private func saveMeals()
    {
        //Archives the meals array to a specific location
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        
        if isSuccessfulSave
        {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        }
        else
        {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals() -> [Meal]?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
        
      
    }
}
