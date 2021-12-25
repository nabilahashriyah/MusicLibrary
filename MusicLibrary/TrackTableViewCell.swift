//
//  TrackTableViewCell.swift
//  MusicLib
//
//  Created by Nabilah Ashriyah on 25/12/21.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
