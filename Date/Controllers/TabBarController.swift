//
//  TabBarController.swift
//  Date
//
//  Created by macbook on 5/26/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav1 = createTab(vc: HomeViewController(), image: "alarm")
        let nav2 = createTab(vc: TimerViewController(), image: "timer")
        let nav3 = createTab(vc: StopWatchController(), image: "stopwatch")
        let nav4 = createTab(vc: AboutAPPController(), image: "about")
        
        
        self.viewControllers = [nav1, nav2, nav3, nav4]
        
    }
    
    func createTab(vc: UIViewController, image: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = UIImage.resizeImage(named: image, height: 32, width: 32)
        tabBar.tintColor = UIColor(red: 276/255, green: 225/255, blue: 69/255, alpha: 1)
        tabBar.barTintColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
        return nav
    }
}

extension UIImage {
    static func resizeImage(named: String, height: CGFloat, width: CGFloat) -> UIImage {
        guard let image = UIImage(named: named) else { return UIImage() }
        let targetSize = CGSize(width: width, height: height)
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize
        if (widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 1, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return newImage
    }
}

