//
//  AppDelegate.swift
//  DroneFlight
//
//  Created by Benjamin Durao on 10/5/16.
//  Copyright © 2016 CCSU. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let locationManager = CLLocationManager()
    
    private func application(application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [NSObject: AnyObject]?) -> Bool {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
        UIApplication.shared.cancelAllLocalNotifications()
        return true
    }
    
    func handleEvent(forRegion region: CLRegion!) {
        // Show an alert if application is active
        if UIApplication.shared.applicationState == .active {
            let message = "You have entered a no fly zone."
            let mapVC = window?.rootViewController as! MapViewController
                mapVC.showSimpleAlert(title: "Alert!", message: message)
        }
        else {
            // Otherwise present a local notification
            let notification = UILocalNotification()
            notification.alertBody = "You have entered a no fly zone."
            notification.soundName = "Default"
            UIApplication.shared.presentLocalNotificationNow(notification)
        }
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            handleEvent(forRegion: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            handleEvent(forRegion: region)
        }
    }
}
