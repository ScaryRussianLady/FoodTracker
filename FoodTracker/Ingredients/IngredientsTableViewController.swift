//
//  IngredientsTableViewController.swift
//  FoodTracker
//
//  Created by Annija Balode on 04/07/2018.
//  Copyright © 2018 Annija Balode. All rights reserved.
//

import UIKit
import os.log

class IngredientsTableViewController: UIViewController, UITextViewDelegate {
    
    
    //MARK: Properties
    @IBOutlet weak var textViewField: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveButtonIngredients: UIBarButtonItem!
    
    var ingredients: String?
  
    override func viewDidLoad() {
        
//        //To save the string
//        UserDefaults.standard.set("String", value(forKey: "Ingredients"))
//
//        //To retrieve from the key
//        let string = UserDefaults.standard.object(forKey: "Ingredients")
//        print(string!)
        
        super.viewDidLoad()
        
        textViewField.text = ingredients
        
    self.view.backgroundColor = UIColor(hue: 0.7778, saturation: 0.15, brightness: 0.92, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = UIColor(hue: 0.7778, saturation: 0.30, brightness: 0.92, alpha: 1)
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        
       
    textViewField.delegate = self
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { [weak self] (notification) in
            guard let strongSelf = self else { return }
            
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
                strongSelf.bottomConstraint.constant = keyboardSize.height + 2
                strongSelf.view.layoutIfNeeded()
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { [weak self] (notification) in
            guard let strongSelf = self else { return }
            
            strongSelf.bottomConstraint.constant = 0.0
            strongSelf.view.layoutIfNeeded()
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Save" {
            textViewField.resignFirstResponder()
            ingredients = textViewField.text
        }
    }
   
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: UITextViewDelegate
    
 
    
//    func textViewShouldReturn(_ textView: UITextView) -> Bool
//    {
//        textView.resignFirstResponder()
//        return true
//    }
    
    

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
    
    func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    
    


  
    
    //MARK: Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        guard let button2 = sender as? UIBarButtonItem, button2 === saveButtonIngredients else
//        {
//            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
//            return
//        }
//    }
    
}
