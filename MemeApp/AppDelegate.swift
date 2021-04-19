//
//  AppDelegate.swift
//  MemeApp
//
//  Created by Avendi Sianipar on 16/04/21.
//  Copyright © 2021 Avendi Sianipar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var memes = [MemeModel]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

