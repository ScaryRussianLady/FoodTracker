//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Annija Balode on 02/07/2018.
//  Copyright © 2018 Annija Balode. All rights reserved.
//

import UIKit
import Social

//This imports the unified logging system. Lets you send messages to the console, this gives more control over when messages appear and how they are saved
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   

    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.layer.shadowColor = UIColor.black.cgColor
            nameTextField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            nameTextField.layer.shadowRadius = 2.0
            nameTextField.layer.shadowOpacity = 0.3
        }
    }
    @IBOutlet weak var photoImageView: UIImageView!
    {
        didSet {
            photoImageView.layer.shadowColor = UIColor.black.cgColor
            photoImageView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            photoImageView.layer.shadowRadius = 5.0
            photoImageView.layer.shadowOpacity = 0.3
        }
    }
    
    @IBOutlet weak var ingredientsButton: UIButton!
    
   @IBOutlet weak var ratingControl: RatingControl!


    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    /*
 This value is either passed by 'MealTableViewController' in 'prepare(for:sender:)'
 or constructed as part of adding a new meal
 */

    //This declares a property on MealViewController that is an 'optional' Meal
    //This means that it can be nil at any point
    var meal: Meal?
    var ingredients: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor(hue: 0.7778, saturation: 0.15, brightness: 0.92, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(hue: 0.7778, saturation: 0.30, brightness: 0.92, alpha: 1)

        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        //Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self //'self' refers to the ViewController class
        
        //Set up views if editing an existing Meal
        if let meal = meal
        {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
            ingredients = meal.ingredients
        }
        
        //Enable the 'save' button only if the text field has a valid Meal name
        updateSaveButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let ingredientsButtonTitle = ingredients == nil || ingredients!.isEmpty ? "Add Ingredients" : "View Ingredients" // ':' can be used as 'else'
        ingredientsButton.setTitle(ingredientsButtonTitle, for: .normal)
    }
    
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
    }
    
    
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the 'save' button while editing
        saveButton.isEnabled = false
    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Hide the keyboard
        textField.resignFirstResponder()
        
        return true
        //Returns a Boolean value that indicates whether the system should process the press of the return key
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        //Check if the text field has text in it, enables the 'save' button if it does
        updateSaveButtonState()
        
        //Sets the title of the scene to that text
        navigationItem.title = textField.text
        
    }
    
   
    
    
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
        
        
    {
        //Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
      
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else
        {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        //Set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    
   
    
    
    //MARK: Navigation

    
    
    @IBAction func cancel(_ sender: UIBarButtonItem)
    {
        
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways
        //Creates a boolean value that indicates whether the view controller that presented this scene is of type 'UINavigationController'
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
    
        if isPresentingInAddMealMode
        {
            //Dismisses the modal scene and animates the transition back to the previous scene
            dismiss(animated: true, completion: nil)
        }
        
            //Else is called if the user is editing an existing meal
            //Dismisses the meal detail scene and returns the user to the meal list
        else if let owningNavigationController = navigationController
        {
            owningNavigationController.popViewController(animated: true)
        }
        
            //Only executes if the meal detail scene is not presented inside a modal navigation controller
            //Also if the meal detail scene was not pushed onto a navigation stack
        else
        {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        
        
    }
    
    
    //This method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddIngredients" {
            let navController = segue.destination as? UINavigationController
            let viewController = navController?.topViewController as? IngredientsTableViewController
            viewController?.ingredients = ingredients
        }
        //Configure the destination view controller only when the save button is pressed
        //This verifies that the sender is a button
        // '===' checks that the 'sender' and 'saveButton' outlet are the same
        guard let button = sender as? UIBarButtonItem, button === saveButton else
        {
            
            os_log("The save button was not pressed, cancelling.", log: OSLog.default, type: .debug)
            return
        }
        
        //Creates constants for name of meal, photo and the rating of it
        //The '??' is used to return the value of an optional if the optional has a value
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //Configures the meal property with the appropriate values before the segue executes
        //Set the meal to be passed to MealTableViewController after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating, ingredients: ingredients)
        
        
        super.prepare(for: segue, sender: sender)
        
    }
    
    @IBAction func didCancelIngredients(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func didSaveIngredients(_ segue: UIStoryboardSegue) {
        guard let viewController = segue.source as? IngredientsTableViewController else { fatalError("Wrong segue source type") }
        
        ingredients = viewController.ingredients
    }
    
    
    
    //MARK: Actions

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer)
    {
        //Hide the keyboard
        nameTextField.resignFirstResponder() //This ensures that when the user taps the image whilst typing, the keyboard is dismissed
        
        //UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: Private Methods
    
    //A helper method to disable the save button if the text field is empty
    private func updateSaveButtonState()
    {
        //Disable the 'save' button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
 
    
    
    
   
        
    
    
}

