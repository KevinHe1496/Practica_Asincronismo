//
//  TransformationsViewCell.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 28/11/24.
//

import UIKit

class TransformationsViewCell: UITableViewCell {
    
    @IBOutlet weak var transfNameLabel: UILabel!
    @IBOutlet weak var transformationImageView: UIImageView!
    static let identifier = String(describing: TransformationsViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
