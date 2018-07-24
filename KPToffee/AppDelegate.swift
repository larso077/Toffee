//
//  AppDelegate.swift
//  KPToffee
//
//  Created by Erik Fisch on 3/17/17.
//  Copyright © 2017 Erik Fisch. All rights reserved.
//

import UIKit
import AVFoundation
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch let error as NSError {
            print(error)
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print(error)
        }
        
        // stripe 
        Stripe.setDefaultPublishableKey("pk_test_TbwHMZfI7xc4eAA9ddMtQKS5")
        
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

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let components = URLComponents(string: url.absoluteString)
        
        guard let code = components?.queryItems?.filter({ (item) in item.name == "verificationCode" }).first?.value else {
            return false
        }
        
        KPService.getJSON(withURLString: "/API/Customer/VerifyCustomerEmail.ashx", params: ["VerificationCode": code]) { (jsonValues, error) in
            if let safeError = error {
                //MessageCenter.showMessage(rootViewController: nil, message: "Could not complete verification, please try again.")
                print(safeError)
                return
            }
            
            guard let values = jsonValues else {
                return
            }
            
            KPAuthentication.shared.login(userValues: values)
        }
        
        return true
    }
}

