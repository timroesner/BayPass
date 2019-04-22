//
//  AppDelegate.swift
//  BayPass
//
//  Created by Tim Roesner on 9/14/18.
//  Copyright © 2018 Tim Roesner. All rights reserved.
//

import Stripe
import UIKit

let transitSystem = System()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let vc = TabViewController()
        window?.rootViewController = vc

        if isRelease() {
            transitSystem.getAllStations()
        }

        // Stripe
        STPPaymentConfiguration.shared().publishableKey = Credentials().stripeKey
        STPPaymentConfiguration.shared().appleMerchantIdentifier = Credentials().merchantId

        if ProcessInfo.processInfo.arguments.contains("UITests") {
            UIApplication.shared.keyWindow?.layer.speed = 100
        }
        return true
    }

    func applicationWillResignActive(_: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_: UIApplication) {
        UserManager.shared.save()
    }

    func applicationWillEnterForeground(_: UIApplication) {
        NotificationCenter.default.post(Notification(name: .willEnterForeground))
    }

    func applicationDidBecomeActive(_: UIApplication) {
        UserManager.shared.load()
    }

    func applicationWillTerminate(_: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
        
    func isRelease() -> Bool {
        var isRelease: Bool = true
        assert({ isRelease = false; return true }())
        return isRelease
    }
}
