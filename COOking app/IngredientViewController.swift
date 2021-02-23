//
//  IngredientViewController.swift
//  COOking app
//
//  Created by 井上げんき on 2020/11/23.
//

//import UIKit
//import KRProgressHUD
//import NCMB
////キャッシュライブラリ
////一時的にデータを保存するもの
////一時的にデータをURlに変えてそのURlにアクセスしてデータをもっていく
//import  Kingfisher
////UITextfielddelegate = Textfieldを任せる
//
//class IngredientViewController: UIViewController, UITextFieldDelegate {
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        <#code#>
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        <#code#>
////    }
////
//
//    var posts = [Post]()
//
//    @IBOutlet weak var SaveCodeTextfield: UITextField!
//
//    @IBOutlet weak var codeTextfield: UITextField!
//
//    @IBOutlet weak  var peopleTextfield: UITextField!
//
//    @IBOutlet var recipeTextfield: UITextField!
//
//    @IBOutlet var recipe2Textfield: UITextField!
//   // @IBOutlet var PostTableview: UITableView!
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        SaveCodeTextfield.delegate = self
//        codeTextfield.delegate = self
//        peopleTextfield.delegate = self
//        recipeTextfield.delegate = self
//        recipe2Textfield.delegate = self
//
//
//        //キーボボードに数字を打つコード
//        self.SaveCodeTextfield.keyboardType = UIKeyboardType.numberPad
//        self.codeTextfield.keyboardType = UIKeyboardType.numberPad
//        self.peopleTextfield.keyboardType = UIKeyboardType.numberPad
//        //SaveCodeはOutletで自分で作ったTextFieldの名前です
//
////        //Cellの取得するコード
////        let nib = UINib(nibName: "POSTCONTENTTableViewCell", bundle: Bundle.main)
////        //nibの登録するコード
////        PostTableview.register(nib, forCellReuseIdentifier: "Cell")
////
////
////        PostTableview.rowHeight = 189
//
//
//        // フォロー中のユーザーを取得する。その後にフォロー中のユーザーの投稿のみ読み込み
//        //loadFollowingUsers()
//
//    }
//
//
//
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return posts.count
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
////        //ここから追加
////        cell?.textLabel?.text = posts[indexPath.row].text1
////
////
////
////
////
////
////
//////
////        cell?.imageView?.kf.setImage(with: URL(string: posts[indexPath.row].imageUrl))
////
////        return (cell)!
////        //Readはqueryを使う
////        //messageクラスから読み込むので
////
////
////
////        //query.whereを使うと絞り込みができるため多いいときは便利
////        //query?.whereKey("text", equalTo: "おはよう")
////        //        query?.whereKey("caroli", equalTo: "45")
////        //        query?.whereKey("howMany", equalTo: "aaaa")
////        //        query?.whereKey("ingredient1", equalTo: "ブロッコリー")
////        //        query?.whereKey("ingredient2", equalTo: "玉ねぎ")
////        //        query?.whereKey("minute", equalTo: "45")
////        //
////    }
//
////    func Narrow() {
////        let query = NCMBQuery(className: "Post")
////
////        query?.findObjectsInBackground( {(result, error) in
////
////
////            if error != nil {
////                print("error")
////
////            }else{
////                //resultのany型を変える必要がある
////                var messages = result as! [NCMBObject]
////                //messagesの最新のものを取り出す
////                //printに出力したテキストだけを取り出すコード
////                // textだけを取り出したいからOb
////                //ojectforKeyを使う
////                //ダウンキャストさせるが今回字列のstringを使う
////                //  var text = messages.last?.object(forKey: "text") as! String
////                //TextFieldに突っ込んであげるコード
////
////
////
////
////            }
////
////
////        })
////
////
////
////
////
////    }
//
//
//    //    var preArticleArray:[ArticleQueryData] = [] //データベースからfetchした全記事情報を入れる配列
//    //    var searchArticleArray:[ArticleQueryData] = [] //検索によるフィルタリング後の記事情報を入れる配列
//    //    var conditions = [(ArticleQueryData) -> Bool]() //複数単語の検索で使用
//    //
//
//
//    //Aの関数
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        //loadTimeline(serchText: textField.text!)
//        let query = NCMBQuery(className: "Post")
//        query?.whereKey("text1", equalTo:  SaveCodeTextfield.text)
//        query?.whereKey("text2", equalTo: codeTextfield.text)
//        query?.whereKey("text3", lessThan: peopleTextfield.text)
//        query?.whereKey("text4", lessThan: recipeTextfield.text)
//        query?.whereKey("text5", lessThan: recipe2Textfield.text)
//        textField.resignFirstResponder()
//    }
//
//
//
//
//
//
//
//
//
//
//
//
//
//    //NCMbから追加したものを読み込んでいく
//    func loadTimeline(serchText: String) {
//        //NCMB.current()が本当に空にならないように例外処理を書くこと
//        guard let currentUser = NCMBUser.current() else {
//
//            //ログインに戻る
//            //nil だった場合に戻ること
//            //ログイン画面に戻したいから
//
//            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
//            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationcontroller")
//            //このアプリの一番下のデータを取得することができる
//            UIApplication.shared.keyWindow?.rootViewController = rootViewController
//
//            //ログイン状態の保持
//            let ud = UserDefaults.standard
//            //false = ログインしていない
//            ud.setValue(false, forKey:"islogin")
//            ud.synchronize()
//            return
//
//        }
////       @IBAction func read()  {
////        //query = 仕様書　検索の要件をまとめる
////        let query = NCMBQuery(className: "Post")
////
////        // 降順
////      //  query?.order(byDescending: "createDate")
////
////        if serchText != nil{
////            print("error")
////
////        }else{
////            query?.whereKey("text1", equalTo:  SaveCodeTextfield.text)
////            query?.whereKey("text2", equalTo: codeTextfield.text)
////            query?.whereKey("text3", lessThan: peopleTextfield.text)
////            query?.whereKey("text4", lessThan: recipeTextfield.text)
////            query?.whereKey("text5", lessThan: recipe2Textfield.text)
////        }
////
//        // 投稿したユーザーの情報も同時取得
//       // query?.includeKey("user")
//
//        // フォロー中の人 + 自分の投稿だけ持ってくる
//        //
//
//
////        query?.whereKey("text", equalTo: posts)
//
//        // オブジェクトの取得
//        query?.findObjectsInBackground({ (result, error) in
//            if error != nil {
//               print("error")
//                //                        SVProgressHUD.showError(withStatus: error!.localizedDescription)
//            } else {
//                print(result)
//                // 投稿を格納しておく配列を初期化(これをしないとreload時にappendで二重に追加されてしまう)
//                self.posts = [Post]()
//
//                for postObject in result as! [NCMBObject] {
//                    // ユーザー情報をUserクラスにセット
//                    let user = postObject.object(forKey: "user") as! NCMBUser
//
//                    // 退会済みユーザーの投稿を避けるため、activeがfalse以外のモノだけを表示
//                    if user.object(forKey: "active") as? Bool != false {
//                        // 投稿したユーザーの情報をUserモデルにまとめる
//                        let userModel = User(objectId: user.objectId, userName: user.userName)
//                        userModel.displayName = user.object(forKey: "displayName") as? String
//
//                        // 投稿の情報を取得
//                        let imageUrl = postObject.object(forKey: "imageUrl") as! String
//                        let text1 = postObject.object(forKey: "text1") as! String
//                        let text2 = postObject.object(forKey: "text2") as! String
//                        let text3 = postObject.object(forKey: "text3") as! String
//                        let text4 = postObject.object(forKey: "text4") as! String
//                        let text5 = postObject.object(forKey: "text5") as! String
//
//                        // 2つのデータ(投稿情報と誰が投稿したか?)を合わせてPostクラスにセット
////                        let post = Post(objectId: postObject.objectId, user: userModel, imageUrl: imageUrl, text: text,  createDate: postObject.createDate)
//
//                        let post = Post(objectId: postObject.objectId, user: userModel, imageUrl: imageUrl, text1: text1, text2: text2, text3: text3, text4: text4, text5: text5, createDate: postObject.createDate)
//                        // likeの状況(自分が過去にLikeしているか？)によってデータを挿入
//                        let likeUsers = postObject.object(forKey: "likeUser") as? [String]
//                        if likeUsers?.contains(currentUser.objectId) == true {
//                            post.isLiked = true
//                        } else {
//                            post.isLiked = false
//                        }
//
//                        // いいねの件数
//                        if let likes = likeUsers {
//                            post.likeCount = likes.count
//                        }
//
//                        // 配列に加える
//                        self.posts.append(post)
//                    }
//                }
//
//                // 投稿のデータが揃ったらTableViewをリロード
//                //self.PostTableview.reloadData()
//            }
//        })
//    }
//    }
//
//
//    //@IBAction func save() {
//    //NCMBObject = NCMBのデータを扱うやつ
//    //classnameに保存したいクラスを書く
//    //  let object = NCMBObject(className: "message")
//    //setObjectを書くことで値がObjectに入る
//    //入力された文字を入れたいからsampleTextFieldを書く
//    //object?.setObject((recipeTextfield.text), forKey: "text")
//    //object?.setObject((recipe2Textfield.text), forKey: "Text");        object?.saveInBackground({ (error) in
//    //  if error != nil {
//    //    print("error")
//
//    //}else{
//    //  print("success")
//    //}
//    //})
//
//
//
//
//
//
//    //}
//
//    //
//    //    override func didReceiveMemoryWarning() {
//    //          super.didReceiveMemoryWarning()
//    //          // Dispose of any resources that can be recreated.
//    //      }
//
//
//    //func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    //    searchArticleArray.removeAll()
//    //    self.view.endEditing(true)
//    //
//    //    if let word = searchBar.text {
//    //        if(word == "") {
//    //            return
//    //        } else if word.contains(" ") { //検索窓に入力された文字列を、半角スペース分割する。
//    //            let words:[String] = word.components(separatedBy: " ")
//    //            searchFetchArticleData(searchWords:words)
//    //            KRProgressHUD.show()
//    //
//    //        } else {
//    //            searchFetchArticleData(searchWords:[word])
//    //            KRProgressHUD.show()
//    //        }
//    //    }
//    //}
//
//
//// @IBAction func(serchText: String){
////
////
////        let query = NCMBQuery(className: "Post")
////        query?.whereKey("Post", equalTo:  SaveCodeTextfield.text)
////        query?.whereKey("Post", equalTo: codeTextfield.text)
////        query?.whereKey("Post", lessThan: peopleTextfield.text)
////        query?.whereKey("Post", lessThan: recipeTextfield.text)
////        query?.whereKey("Post", lessThan: recipe2Textfield.text)
////        textField.resignFirstResponder()
////
////        return true
////    }
////
//
//
//
//
//
//    //ボタンを押した時に読み込みをさせるコード
//
//
//
//
//
//
//
//
//    //キーボードのDONEボタンを押した時に呼ばれるコード
//    //キーボードを閉じるコード
////    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////
////
////        //キーボードを閉じるコード
////        textField.resignFirstResponder()
////
////        return true
////    }
////
////    func textFieldDidChangeSelection(_ textField: UITextField) {
////        if textField.tag == 1{
////            if textField.text?.count != 0{
////                loadTimeline(serchText: textField.text!)
////            }
////        }
////    }
//
//
//
//
