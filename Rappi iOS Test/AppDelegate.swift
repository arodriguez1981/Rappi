//
//  AppDelegate.swift
//  Rappi iOS Test
//
//  Created by Alex Rodriguez on 04/08/21.
//  Copyright © 2021 Alex Rodriguez. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 2,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 2) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
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
    
    class func jsonToNSData(_ json: AnyObject) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
    
    class func getTopMostViewController() -> UIViewController? {
//        if var topController = UIWindow.keyWindow!.rootViewController {
//            while let presentedViewController = topController.presentedViewController {
//                topController = presentedViewController
//            }
//            return topController
//        }
//        return nil
        return (UIApplication.shared.delegate?.window!!.rootViewController!)!
    }
    
    
    class func goElementDetails(viewController: UIViewController, element: AnyObject!, type: String){
        if type == "Movie"{
            let vc = MovieDetailsViewController.instantiate(fromAppStoryboard: .MovieDetails)
            vc.elementId = (element as! Movie).id
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = EpisodeDetailsViewController.instantiate(fromAppStoryboard: .EpisodeDetails)
            vc.elementId = (element as! Serie).id
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
       
    }


}

