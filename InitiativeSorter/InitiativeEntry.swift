//
//  InitiativeEntry.swift
//  InitiativeSorter
//
//  Created by Geoffrey Caven on 2017-09-06.
//  Copyright © 2017 Geoffrey Caven. All rights reserved.
//

import UIKit

class InitiativeEntry {
	// Mark: Properties
	var name: String
	var initiative: Int
	
	// Mark: Initialization
	init?(name: String, initiative: Int) {
		
		guard !name.isEmpty else {
			return nil
		}
		
		guard initiative >= 0 else {
			return nil
		}
		
		self.name = name
		self.initiative = initiative
	}
  
}
