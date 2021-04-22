//
//  MemeTableCell.swift
//  MemeApp
//
//  Created by Avendi Sianipar on 22/04/21.
//  Copyright © 2021 Avendi Sianipar. All rights reserved.
//

import UIKit

class MemeTableCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(image: UIImage, desc: String) {
        //memeImageView.image = image
        memeDescriptionLabel.text = desc
    }
}
