//
//  AppDelegate.swift
//  Treasure Hunter
//
//  Created by Даниил Марусенко on 09.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // - UI
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        self.window?.rootViewController = casualRootVC()
        return true
    }
    
    func casualRootVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Main")
        return vc
    }

}

