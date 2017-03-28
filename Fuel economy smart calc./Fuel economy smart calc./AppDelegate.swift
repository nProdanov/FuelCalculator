//
//  AppDelegate.swift
//  Fuel economy smart calc.
//
//  Created by Nikolay Prodanow on 3/17/17.
//  Copyright © 2017 Nikolay Prodanow. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var charges: [Charge]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        
        // Override point for customization after application launch.
        let gasStation = GasStation(address: "до Кат север", brandName: "Lukoil", city: "Плевен", id: 109, latitude: 43.435799, longtitude: 24.5996, name: "B128")
        
        self.charges = [
        Charge(chargingDate: Date.init(), gasStation: gasStation, chargedFuel: 62.4, distancePast: 945, price: 2.09, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: 7.2, priceConsumption: 16.0)
        ]
        
        var currentDate = Date.init()
        
        var fuelConsumpt = 1.0
        for index in 0..<40 {
            if index < 10 {
                fuelConsumpt += 1
            }
            else{
                fuelConsumpt -= 1
            }
            
            self.charges?.append(
                Charge(chargingDate: currentDate, gasStation: gasStation, chargedFuel: 65.0, distancePast: 1000, price: 2.0, fuelUnit: "LTR", distanceUnit: "KM", priceUnit: "LV", fuelConsumption: fuelConsumpt, priceConsumption: 13.0))
            currentDate = currentDate.addingTimeInterval(-20*24*60*60)
        }
 
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

