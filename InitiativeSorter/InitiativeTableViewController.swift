//
//  InitiativeTableViewController.swift
//  InitiativeSorter
//
//  Created by Geoffrey Caven on 2017-09-06.
//  Copyright © 2017 Geoffrey Caven. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
	
	// MARK: Properties
	var entries = [InitiativeEntry]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.leftBarButtonItem = editButtonItem
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return entries.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Table view cells are reused and should be dequeued using a cell identifier.
		let cellIdentifier = "InitiativeTableViewCell"
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InitiativeTableViewCell else {
			fatalError("The dequeued cell is not an instance of InitiativeTableViewCell")
		}
		
		// Fetches the appropriate meal for the data source layout.
		let entry = entries[indexPath.row]
		
		cell.nameLabel.text = entry.name
    cell.initiativeLabel.text = String(entry.initiative)
		
		return cell
	}
	
	
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			entries.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		switch(segue.identifier ?? "") {
			
		case "AddItem":
			os_log("Adding a new entry", log: OSLog.default, type: .debug)
			
		case "ShowDetail":
			guard let mealDetailViewController = segue.destination as? CreateEntryViewController else {
				fatalError("Unexpected destination: \(segue.destination)")
			}
			guard let selectedMealCell = sender as? InitiativeTableViewCell else {
				fatalError("Unexpected sender: \(sender ?? "nil")")
			}
			
			guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
				fatalError("The selected cell is not being displayed by the table")
			}
			
			let selectedEntry = entries[indexPath.row]
			mealDetailViewController.entry = selectedEntry
			
		default:
			fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "nil")")
		}
	}
	
	// Mark: Actions
	
	@IBAction func unwindToEntryList(sender: UIStoryboardSegue) {
		if let sourceViewController = sender.source as? CreateEntryViewController, let entry = sourceViewController.entry {
				entries.append(entry)
        entries.sort() { $0.initiative > $1.initiative }
        // ideally would only be using reloadRows on the affected rows
        tableView.reloadData();
		}
	}
}
