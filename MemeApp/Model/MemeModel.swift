//
//  MemeModel.swift
//  MemeApp
//
//  Created by Avendi Sianipar on 19/04/21.
//  Copyright © 2021 Avendi Sianipar. All rights reserved.
//

import UIKit

struct MemeModel {
    var topText: String?
    var bottomText: String?
    var image: UIImage?
    var memedImage: UIImage?
    
    //Locate the Meme storage location
    static func getMeme() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}


