//
//  BlazeWSCApp.swift
//  BlazeWSC
//
//  Created by Javier Etxarri on 21/10/24.
//

import SwiftUI
import BlazeSDK

@main
struct BlazeWSCApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let BLAZE_API = ""
        
        Blaze.shared.initialize(apiKey: BLAZE_API, cachingSize: 500, prefetchingPolicy: .Default, geo: nil) { result in
            switch result {
            case .success:
                print("Blaze SDK successfully initialized")
            case .failure(let error):
                print("Error message in blaze sdk: \(error.errorMessage)")
            }
        }
        
        return true
    }
}
