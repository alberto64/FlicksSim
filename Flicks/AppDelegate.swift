//
//  AppDelegate.swift
//  Flicks
//
//  Created by Karla on 1/23/16.
//  Copyright © 2016 Alberto J. De Jesus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nowPlayingNavControl = storyBoard.instantiateViewControllerWithIdentifier("movieNavControl") as! UINavigationController
        let nowPlayingViewControl = nowPlayingNavControl.topViewController as! MovieViewController
        nowPlayingViewControl.endPoint = "now_playing"
        nowPlayingNavControl.tabBarItem.title = "Now Playing"
        nowPlayingNavControl.tabBarItem.image = UIImage(named: "recorder")
        
        let topRatedNavControl = storyBoard.instantiateViewControllerWithIdentifier("movieNavControl") as! UINavigationController
        let topRatedViewControl = topRatedNavControl.topViewController as! MovieViewController
        topRatedViewControl.endPoint = "top_rated"
        topRatedNavControl.tabBarItem.title  = "Top Rated"
        topRatedNavControl.tabBarItem.image = UIImage(named: "star")
    
        
        
        let popularNavControl = storyBoard.instantiateViewControllerWithIdentifier("movieNavControl") as! UINavigationController
        let popularViewControl = popularNavControl.topViewController as! MovieViewController
        popularViewControl.endPoint = "popular"
        popularNavControl.tabBarItem.title  = "Popular Movies"
        popularNavControl.tabBarItem.image = UIImage(named: "megaphone")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nowPlayingNavControl, topRatedNavControl, popularNavControl]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

