//
//  RePassWordViewController.swift
//  COOking app
//
//  Created by 井上げんき on 2020/10/29.
//

import UIKit
import NCMB

class RePassWordViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var mailadressTextfield: UITextField!

 

    override func viewDidLoad() {
        super.viewDidLoad()
        mailadressTextfield.delegate = self
  
        
       //後で作成する
        
        
        
        
        
       
    }
    
   
    
    @IBAction func repassward() {
        
        
        
        
        let result = NCMBUser.requestPasswordResetForEmail(inBackground: mailadressTextfield.text) { (error) in
            if error != nil {
                print("error")
            }else{
                print("success")
            }
        }
        
//        let result = NCMBUser.requestAuthenticationMailInBackground(mailAddress: "mail@example.com", callback: { result in
//
//
//            switch result {
//                case .success:
//                    // 会員登録用メールの要求に成功した場合の処理
//                    print("会員登録用メールの要求に成功しました")
//                case let .failure(error):
//                    // 会員登録用のメール要求に失敗した場合の処理
//                    print("会員登録用メールの要求に失敗しました: \(error)")
//            }
//        })
        
        
    }
   
}
