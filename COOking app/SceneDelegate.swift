//
//  SceneDelegate.swift
//  COOking app
//
//  Created by 井上げんき on 2020/10/18.
//

import UIKit
import NCMB
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let ud = UserDefaults.standard
        //ログインしているかどうか
       
        
        let islogin = ud.bool(forKey: "islogin")
        
        if islogin == true {
            //もしログイン中だったら
            //Storyboardを動的に起動させるコード
            //StoryBoardを取得する
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           
            //storyboardの最初の画面を作る
            let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootTabBarController")
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            //画面を出しますよの、コード
            self.window?.makeKeyAndVisible()
        }else{
            //ログインしていなかったら
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            
            //storyboardの最初の画面を作る
            let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootNavigationcontroller")
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            //画面を出しますよの、コード
            self.window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

