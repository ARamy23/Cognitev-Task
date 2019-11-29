//
//  VenueTableViewCell.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueDescriptionLabel: UILabel!
    
    func set(model: GroupItem) {
        venueNameLabel.text = model.venue?.name
        venueDescriptionLabel.text = model.venue?.location?.crossStreet
    }
    
}
