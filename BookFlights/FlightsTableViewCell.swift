//
//  FlightsTableViewCell.swift
//  BookFlights
//
//  Created by Khả Như on 14/05/2022.
//  Copyright © 2022 hoangvu. All rights reserved.
//

import UIKit

class FlightsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flyFromLabel: UILabel!
    @IBOutlet weak var flyTimeLabel: UILabel!
    @IBOutlet weak var airLineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
