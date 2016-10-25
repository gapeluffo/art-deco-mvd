//
//  AppDelegate.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/21/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupNavigationBar()

        return true
    }

    private func setupNavigationBar() {    
      UIApplication.sharedApplication().statusBarStyle = .LightContent
      UITabBar.appearance().tintColor = UIColor.whiteColor()
      UINavigationBar.appearance().tintColor = Colors.mainColor
      UINavigationBar.appearance().backgroundColor = Colors.mainColor
      UILabel.appearance().font = UIFont(name: kFontRegular, size: 17.0)

      if let font = UIFont (name: kFontRegular, size: 17) {
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
      }
    }
}
