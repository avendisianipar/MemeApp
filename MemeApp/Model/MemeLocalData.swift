//
//  MemeLocalData.swift
//  MemeApp
//
//  Created by Avendi Sianipar on 12/05/21.
//  Copyright © 2021 Avendi Sianipar. All rights reserved.
//

import UIKit

struct MemeDataModel {
    var topText: String?
    var bottomText: String?
    var image: UIImage?
    var memedImage: UIImage?
}

class MemeLocalData: NSObject {    
    private static var memes = [MemeDataModel]()
    
    private override init() {
    }
    
    static func getMemes() -> [MemeDataModel] {
        return memes
    }
    
    static func getMemes(_ indexPosition: Int) -> MemeDataModel {
        return memes[indexPosition]
    }
    
    static func addMeme(_ meme: MemeDataModel) {
        memes.append(meme)
    }
    
    static func count() -> Int {
        return memes.count
    }
}
