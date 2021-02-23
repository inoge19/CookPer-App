//
//  SignInViewController.swift
//  COOking app
//
//  Created by 井上げんき on 2020/10/21.
//

import UIKit
import NCMB
class SignInViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet var UserIdTextField: UITextField!
    @IBOutlet var PasswardTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        UserIdTextField.delegate = self
        PasswardTextField.delegate = self
        
        
    }
    
    
    //キーボード閉じるコード
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signin() {
    
      //if UserIdTextField.text != nil && PasswardTextField.text != nil
        
        if UserIdTextField.text!.count > 0 && PasswardTextField.text!.count > 0{
            NCMBUser.logInWithUsername(inBackground: UserIdTextField.text!, password: PasswardTextField.text!) { (user,error) in
                
                
                
                if error != nil {
                    
                    print("error")
                }else {
                    //ログイン成功
                    //登録成功
                    //登録したらメインのstoryboardを呼び出すコード
                    //story board取得
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootTabBarController")
                    //このアプリの一番下のデータを取得することができる
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //ログイン状態の保持
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "islogin")
                    ud.synchronize()
                }
        }
           
                
//                if error != nil {
//
//                    print("error")
//                }else {
//                    //ログイン成功
//                    //登録成功
//                    //登録したらメインのstoryboardを呼び出すコード
//                    //story board取得
//                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                    let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootTabBarController")
//                    //このアプリの一番下のデータを取得することができる
//                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
//
//                    //ログイン状態の保持
//                    let ud = UserDefaults.standard
//                    ud.set(true, forKey: "islogin")
//                    ud.synchronize()
//                }
                
            
            
            
        }
       
            
        
    
    }

    @IBAction func forgetPassword() {
        
    }

}
