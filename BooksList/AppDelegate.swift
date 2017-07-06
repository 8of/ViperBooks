//
//  AppDelegate.swift
//  BooksList
//
//  Created by Andrey Konstantinov on 04/06/2017.
//  Copyright © 2017 8of All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let router = Router()
    router.setupRootViewController(on: window?.rootViewController)
    window?.makeKeyAndVisible()

    return true
  }

}
