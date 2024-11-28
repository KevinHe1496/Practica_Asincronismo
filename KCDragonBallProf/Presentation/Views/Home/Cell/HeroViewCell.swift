//
//  HeroViewCell.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 26/11/24.
//

import UIKit

class HeroViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    static let identifier = String(describing: HeroViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
