//
//  MemeCollectionCell.swift
//  MemeApp
//
//  Created by Avendi Sianipar on 22/04/21.
//  Copyright © 2021 Avendi Sianipar. All rights reserved.
//

import UIKit

class MemeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(image: UIImage) {
        //memeImageView.image = image
    }
}
