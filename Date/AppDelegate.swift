//
//  AppDelegate.swift
//  Date
//
//  Created by macbook on 4/3/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = TabBarController()
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }




}

