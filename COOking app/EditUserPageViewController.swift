//
//  EditUserPageViewController.swift
//  COOking app
//
//  Created by 井上げんき on 2020/10/29.
//

import UIKit
import NCMB
import NYXImagesKit
import UITextView_Placeholder

class EditUserPageViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let placeholder = UIImage(named: "Text-placeholder")
    
    @IBOutlet var UserImageView: UIImageView!
    @IBOutlet var UserNameTextField: UITextField!
    @IBOutlet var UserIdTextfield: UITextField!
    @IBOutlet var IntroductionTextView: UITextView!

   
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
       UserImageView.image = placeholder
        IntroductionTextView.placeholder = "ここに自己紹介する"
        IntroductionTextView.delegate = self

        
        //アイコンを丸くするコード
        UserImageView.layer.cornerRadius = UserImageView.bounds.width / 2.0
        UserImageView.layer.masksToBounds = true

    //Textfieldのdelegateの設定
        UserNameTextField.delegate = self
        UserIdTextfield.delegate = self
        IntroductionTextView.delegate = self
        
       //取って、StoryBoard上に表示させるようにするコード
      //usernameがuserIDになる
        if let UserID = NCMBUser.current()?.userName {
        //表示をさせていく
            UserIdTextfield.text = UserID
            
            if let user = NCMBUser.current() {
               
                
                
                //保存したUsernameと自己紹介文を取り出すコード
                UserNameTextField.text = user.object(forKey: "displayname") as? String
                IntroductionTextView.text = user.object(forKey: "introduction") as? String
              //UserIdをBarに表示させるために取り出すコード
                self.navigationItem.title = user.userName
                
                let userId = NCMBUser.current()?.userName
                UserIdTextfield.text = userId
                
                
                
            // ユーザー画像の表示
                       let file = NCMBFile.file(withName: UserID, data: nil) as! NCMBFile
                       file.getDataInBackground { (data, error) in
                           if error != nil {
                               let alert = UIAlertController(title: "画像取得エラー", message: error!.localizedDescription, preferredStyle: .alert)
                               let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                   
                               })
                               alert.addAction(okAction)
                               self.present(alert, animated: true, completion: nil)
                           } else {
                               if data != nil {
                                   let image = UIImage(data: data!)
                                   self.UserImageView.image = image
                               }
                           }
                       }
                
                
                
                
            }else {
                //NCMBUser.current()がnilだったとき
              //ログイン画面に戻したいから
                //ログアウト成功
                let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationcontroller")
                //このアプリの一番下のデータを取得することができる
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                //ログイン状態の保持
                let ud = UserDefaults.standard
               //false = ログインしていない
                ud.setValue(false, forKey:"islogin")
                ud.synchronize()
                
                
                
                
            }
            
           
        }
       
        //画像を取得するコード
        let file = NCMBFile.file(withName: (NCMBUser.current()?.objectId)!, data: nil) as! NCMBFile
        file.getDataInBackground { (data, error) in
            if error != nil {
                print(error)
                
            }else{
                //data表示完了
                let image = UIImage(data: data!)
                self.UserImageView.image = image
                
            }
        }
        
        
        
        
        
        


    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }

    
    
    
    //画像が選ばれた時に読まれる関数のコード
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // info= 取り出された値のこと
        //選んだ画像の情報の中から取り出す
        let selectedImage = info[.originalImage] as! UIImage
       
        
        //写真のリサイズ設定
        let  resize = selectedImage.scale(byFactor: 0.4)
        //Pickerを閉じる
        picker.dismiss(animated: true, completion: nil)
        
        //画像のアップロードのコード
        let data = resize?.pngData()
       //any型からNCMBFile型に変更してあげる
        
       
        let file = NCMBFile.file(withName: NCMBUser.current()?.objectId, data: data) as! NCMBFile
        file.saveInBackground { (error) in
            if error != nil {
                print("error")

            }else{
                //アップロードを完了するとImageViewの中に表示される


                self.UserImageView.image = selectedImage
            }
            
        } progressBlock: { (progress) in
           print(progress)
        }

    }
    
  
    
    
  
    
    @IBAction func SelectImage() {
       
        //Actionを出すためのコード
        let Actioncontroller = UIAlertController(title: "画像の選択", message: "選択して下さい", preferredStyle: .actionSheet)
        //Actionを作っていく
        let CameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
          
            //if文を使ってカメラが使える場合のコードを書く
            //カメラ起動のためのコード
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let picker = UIImagePickerController()
               //何からSourceを使うかを書くため
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
            }else{
                
                print("この機種ではカメラはご使用できません")
            }
            
           
            
            }
                
        let AlbumAction = UIAlertAction(title: "アルバム", style: .default) { (action) in
            
            //if文を使ってアルバムが使える場合のコードを書く
          //  if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                //アルバム起動のためのコード
    let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
//            }else{
//                print("この機種ではアルバムの使用はできません")
//
//            }
            
                
              
            
            
        }
        
        let CancelAction = UIAlertAction(title: "キャンセル", style: .default) { (action) in
            Actioncontroller.dismiss(animated: true, completion: nil)
        }
        //AlertController & AlertActionを付属させるためのコード
        Actioncontroller.addAction(CameraAction)
        Actioncontroller.addAction(AlbumAction)
        Actioncontroller.addAction(CancelAction)
        //上の三つを表示させるためのコード
        self.present(Actioncontroller, animated: true, completion: nil)
                
            
        
        
    }
    
    
    
    
    @IBAction func cancelButton() {
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    //右上の完了ボタンを押して保存するためのコード
    @IBAction func saveUserInfo() {
        let user = NCMBUser.current()
       //Obnjectをセットする（UsreNametextField etc）
        user?.setObject(UserNameTextField.text, forKey: "displayname")
        user?.setObject(UserIdTextfield.text, forKey: "userName")
        user?.setObject(IntroductionTextView.text, forKey: "introduction")
        user?.saveInBackground({ (error) in
            if error != nil {
                
                print(error)
            }else{
                //保存成功
                self.dismiss(animated: true, completion: nil)
                
            }
        })
        
    }

}
