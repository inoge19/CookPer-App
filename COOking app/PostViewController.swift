//
//  PostViewController.swift
//  COOking app
//
//  Created by 井上げんき on 2020/11/10.
//

import UIKit
import NCMB
import NYXImagesKit
import UITextView_Placeholder
import KRProgressHUD



class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    let placeholderImage = UIImage(named: "photo-placeholder")
      var resizedImage: UIImage!
    //サイズを整えた画像
      @IBOutlet var postImageView: UIImageView!
      @IBOutlet var postTextField1: UITextField!
    @IBOutlet var postTextField2: UITextField!
    @IBOutlet var postTextField3: UITextField!
    @IBOutlet var postTextField4: UITextField!
    @IBOutlet var postTextField5: UITextField!
    
    
      @IBOutlet var postButton: UIBarButtonItem!

  
    override func viewDidLoad() {
        super.viewDidLoad()

        postImageView.image = placeholderImage
               postButton.isEnabled = false
//               postTextField.placeholder = "キャプションを書く"
//               postTextField.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let selectedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)]
        as! UIImage
        

           // 画像をリサイズ(0.4以下でよい)
          resizedImage = selectedImage.scale(byFactor: 0.3)

           postImageView.image = resizedImage
            postButton.isEnabled = true
        
           // pickerを閉じる
           picker.dismiss(animated: true, completion: nil)

           confirmContent()
       }
    func textViewDidChange(_ textView: UITextView) {
         confirmContent()
     }

     func textViewDidEndEditing(_ textView: UITextView) {
         // UITextField のファーストレスポンダをやめる（その結果、キーボードが非表示になる）
         textView.resignFirstResponder()
     }
    
    @IBAction func selectImage() {
           let alertController = UIAlertController(title: "画像選択", message: "シェアする画像を選択して下さい。", preferredStyle: .actionSheet)

           let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
               alertController.dismiss(animated: true, completion: nil)
           }

           let cameraAction = UIAlertAction(title: "カメラで撮影", style: .default) { (action) in
               // カメラ起動
               if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
                   let picker = UIImagePickerController()
                   picker.sourceType = .camera
                   picker.delegate = self
                   self.present(picker, animated: true, completion: nil)
               } else {
                   print("この機種ではカメラが使用出来ません。")
               }
           }

           let photoLibraryAction = UIAlertAction(title: "フォトライブラリから選択", style: .default) { (action) in
               // アルバム起動
               if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
                   let picker = UIImagePickerController()
                   picker.sourceType = .photoLibrary
                   picker.delegate = self
                   self.present(picker, animated: true, completion: nil)
               } else {
                   print("この機種ではフォトライブラリが使用出来ません。")
               }
           }

           alertController.addAction(cancelAction)
           alertController.addAction(cameraAction)
           alertController.addAction(photoLibraryAction)
           self.present(alertController, animated: true, completion: nil)
       }
    
    @IBAction func sharePhoto() {
        KRProgressHUD.show()

           // 撮影した画像をデータ化したときに右に90度回転してしまう問題の解消
        UIGraphicsBeginImageContext(resizedImage.size)
          let rect = CGRect(x: 0, y: 0, width: resizedImage.size.width, height: resizedImage.size.height)
           resizedImage.draw(in: rect)
           resizedImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()

        let data = resizedImage.pngData()
           let file = NCMBFile.file(with: data) as! NCMBFile
           file.saveInBackground({ (error) in
               if error != nil {
                KRProgressHUD.dismiss()
                   let alert = UIAlertController(title: "画像アップロードエラー", message: error!.localizedDescription, preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in

                   })
                   alert.addAction(okAction)
                   self.present(alert, animated: true, completion: nil)
               } else {
                   // 画像アップロードが成功
                   let postObject = NCMBObject(className: "Post")

                if self.postTextField1.text!.count == 0 {
                       print("入力されていません")
                       return
                   }
                if self.postTextField2.text!.count == 0 {
                       print("入力されていません")
                       return
                   }
                if self.postTextField3.text!.count == 0 {
                       print("入力されていません")
                       return
                   }
                
                if self.postTextField4.text!.count == 0 {
                       print("入力されていません")
                       return
                   }
                if self.postTextField5.text!.count == 0 {
                       print("入力されていません")
                       return
                   }
                
                
                   postObject?.setObject(self.postTextField1.text!, forKey: "text1")
                postObject?.setObject(self.postTextField2.text!, forKey: "text2")
                postObject?.setObject(self.postTextField3.text!, forKey: "text3")
                postObject?.setObject(self.postTextField4.text!, forKey: "text4")
                postObject?.setObject(self.postTextField5.text!, forKey: "text5")
             

                postObject?.setObject(NCMBUser.current(), forKey: "user")
                   let url = "https://mbaas.api.nifcloud.com/2013-09-01/applications/xi5BqEVZdlaIyKso/publicFiles/" + file.name
                   postObject?.setObject(url, forKey: "imageUrl")
                   postObject?.saveInBackground({ (error) in
                       if error != nil {
                        KRProgressHUD.show(withMessage: "エラーが発生しました")
                       } else {
                        KRProgressHUD.dismiss()
                           self.postImageView.image = nil
                           self.postImageView.image = UIImage(named: "photo-placeholder")
                          
                        self.postTextField1.text = nil
                        self.postTextField2.text = nil
                        self.postTextField3.text = nil
                        self.postTextField4.text = nil
                        self.postTextField5.text = nil
                        
                        self.tabBarController?.selectedIndex = 0
                       }
                   })
               }
           }) { (progress) in
               print(progress)
           }
       }
    func confirmContent() {
        if postTextField1.text!.count > 0 && postTextField2.text!.count > 0 && postTextField3.text!.count > 0 && postTextField4.text!.count > 0 && postTextField5.text!.count > 0 && postImageView.image != placeholderImage {
               postButton.isEnabled = true
           } else {
               postButton.isEnabled = false
           }

       }
    
    @IBAction func cancel() {
          if postTextField1.isFirstResponder == true {
              postTextField1.resignFirstResponder()
          }
        if postTextField2.isFirstResponder == true {
            postTextField2.resignFirstResponder()
        }
        if postTextField3.isFirstResponder == true {
            postTextField3.resignFirstResponder()
        }
        if postTextField4.isFirstResponder == true {
            postTextField4.resignFirstResponder()
        }
        if postTextField5.isFirstResponder == true {
            postTextField5.resignFirstResponder()
        }
          let alert = UIAlertController(title: "投稿内容の破棄", message: "入力中の投稿内容を破棄しますか？", preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
              self.postTextField1.text = nil
            self.postTextField2.text = nil
            self.postTextField3.text = nil
            self.postTextField4.text = nil
            self.postTextField5.text = nil
            
            self.postImageView.image = UIImage(named: "photo-placeholder")
              self.confirmContent()
          })
          let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) in
              alert.dismiss(animated: true, completion: nil)
          })
          alert.addAction(okAction)
          alert.addAction(cancelAction)
          self.present(alert, animated: true, completion: nil)
      }
    
  

  }

    



