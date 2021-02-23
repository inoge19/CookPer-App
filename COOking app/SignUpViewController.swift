//
//  SignUpViewController.swift
//  COOking app
//
//  Created by 井上げんき on 2020/10/21.
//

import UIKit
import NCMB
class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        userIdTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  

    @IBAction func signUp() {
        //user作成
        let user = NCMBUser()
        
        //UserIDの文字制限のコード
        //文字数を取得する
        if userIdTextField.text!.count <= 4 {
            print("文字数が足りません")
            return
        }
            
            
        
        //username= userID
        user.userName = userIdTextField.text!
        user.mailAddress = emailTextField.text!
        
    //もしpassword と　confirmが正しかったら
        if passwordTextField.text == confirmTextField.text {
            
            //代入する
            user.password = userIdTextField.text!
            
        }else{
            print("パスワードの不一致")
            //後でアラートの表示作成する
        }
        
        //userName と password を設定して signUpInBackground で登録処理を行います。
        user.signUpInBackground { (error) in
            if error != nil {
                //エラーがあった場合
                print(error)
                self.emailTextField.placeholder = "無効なメールアドレスです"
            }else {
                //登録成功
                //登録したらメインのstoryboardを呼び出すコード
                //story board取得
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootTabBarController")
                //このアプリの一番下のデータを取得することができる
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                //結果画面の切り返しができる
                
                
                //ログイン状態の保持
                let ud = UserDefaults.standard
                ud.set(true, forKey: "islogin")
                ud.synchronize()
            }
            
            
            
            
            
        }
        
     
        
        
        
    }




}




