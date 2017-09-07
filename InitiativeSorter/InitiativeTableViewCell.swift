//
//  InitiativeTableViewCell.swift
//  InitiativeSorter
//
//  Created by Geoffrey Caven on 2017-09-06.
//  Copyright © 2017 Geoffrey Caven. All rights reserved.
//

import UIKit

class InitiativeTableViewCell: UITableViewCell {
	
	//MARK: Properties
  @IBOutlet weak var initiativeLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state
	}
	
}
