//
//  CreateEntryViewController.swift
//  InitiativeSorter
//
//  Created by Geoffrey Caven on 2017-09-06.
//  Copyright © 2017 Geoffrey Caven. All rights reserved.
//

import UIKit
import os.log

class CreateEntryViewController: UIViewController,
  UITextFieldDelegate,
  UINavigationControllerDelegate {
  
    // Mark: Properties
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var initiativeField: UITextField!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  var entry: InitiativeEntry?

  override func viewDidLoad() {
    super.viewDidLoad()
    nameField.delegate = self
    initiativeField.delegate = self
      
    // Set up if editing existing meal
    if let entry = entry {
      navigationItem.title = entry.name
      nameField.text = entry.name
      initiativeField.text = String(entry.initiative)
    }
      
    // Disable the save button on new meals until user enters a name
    updateSaveButtonState()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  // MARK: UITextFieldDelegate
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    updateSaveButtonState()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //hide the keyboard
    textField.resignFirstResponder()
    return true
  }
  
  // Mark: Navigation
  
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
    let isPresentingInAddMealMode = presentingViewController is UINavigationController
    if (isPresentingInAddMealMode) {
      dismiss(animated: true, completion: nil)
    } else if let owningNavigationController = navigationController {
      owningNavigationController.popViewController(animated: true)
    } else {
      fatalError("The MealViewController is not inside a navigation controller.")
    }
  }
  
  // This method lets you configure a view controller before it's presented.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
      return
    }
    
    let name = nameField.text ?? ""
    let initiative = Int(initiativeField.text!) ?? 0
    
    // Set the meal to be passed to MealTableViewController after the unwind segue.
    entry = InitiativeEntry(name: name, initiative: initiative)
  }

  // MARK: Private Methods
  
  private func updateSaveButtonState() {
    // Disable the save button if the text field is empty
    let name = nameField.text ?? ""
    saveButton.isEnabled = !name.isEmpty
  }
}
