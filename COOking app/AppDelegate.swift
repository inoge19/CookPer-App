//
//  AppDelegate.swift
//  COOking app
//
//  Created by 井上げんき on 2020/10/18.
//

import UIKit
import NCMB

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
        NCMB.setApplicationKey("d9eb7d4e075f648b76ba0653684891a16097ffab46a2327419f905ca56251956"  , clientKey:"ba788a386023004bfc805a70a5f6a1e7a4ba37782567759703a80e38e57d1f27"
        
        )
        
        
        let ud = UserDefaults.standard
       //        //ログインしているかどうか
       //
       //
              let islogin = ud.bool(forKey: "islogin")
        
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }

        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
            // Called when the user discards a scene session.
            // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
            // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        }

//        let ud = UserDefaults.standard
//        //ログインしているかどうか
//       
//        
//        let islogin = ud.bool(forKey: "islogin")
//        
//        if islogin == true {
//            //もしログイン中だったら
//            //Storyboardを動的に起動させるコード
//            //StoryBoardを取得する
//            let storyboard = UIStoryboard(name: "main", bundle: Bundle.main)
//           
//            //storyboardの最初の画面を作る
//            let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootTabBarController")
//            self.window?.rootViewController = rootViewController
//            self.window?.backgroundColor = UIColor.white
//            //画面を出しますよの、コード
//            self.window?.makeKeyAndVisible()
//        }else{
//            //ログインしていなかったら
//            let storyboard = UIStoryboard(name: "", bundle: Bundle.main)
//            
//            //storyboardの最初の画面を作る
//            let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootNavigationcontroller")
//            self.window?.rootViewController = rootViewController
//            self.window?.backgroundColor = UIColor.white
//            //画面を出しますよの、コード
//            self.window?.makeKeyAndVisible()
//        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

