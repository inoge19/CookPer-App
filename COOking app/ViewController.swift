//
//  ViewController.swift
//  COOking app
//
//  Created by 井上げんき on 2020/10/18.
//

import UIKit
import NCMB
import Kingfisher
import KRProgressHUD
import SwiftDate
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,TimelineTableViewCellDelegate{
   
    var selectedPost: Post?

      var posts = [Post]()

      var followings = [NCMBUser]()
    
    @IBOutlet var timeLineTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        timeLineTableView.dataSource = self
        timeLineTableView.delegate = self
        
        //Cellの取得するコード
        let nib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle.main)
        //nibの登録するコード
        timeLineTableView.register(nib, forCellReuseIdentifier: "Cell")
        //TableViewの不要な線を消すコード
        timeLineTableView.tableFooterView = UIView()
        // 引っ張って更新
               setRefreshControl()
        
        timeLineTableView.rowHeight = 700
        
        
        loadTimeline()

               // フォロー中のユーザーを取得する。その後にフォロー中のユーザーの投稿のみ読み込み
               //loadFollowingUsers()
        
    }
    
    
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count,"count")
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as!  TimelineTableViewCell
        cell.delegate = self
                cell.tag = indexPath.row

                let user = posts[indexPath.row].user
                cell.userNameLabel.text = user.displayName
                let userImageUrl = "https://mbaas.api.nifcloud.com/2013-09-01/applications/xi5BqEVZdlaIyKso  /publicFiles/" + user.objectId
        cell.TextFiled1.text = posts[indexPath.row].text1
        cell.TextFiled2.text = posts[indexPath.row].text2
        cell.TextFiled3.text = posts[indexPath.row].text3
        cell.TextFiled4.text = posts[indexPath.row].text4
        cell.TextFiled5.text = posts[indexPath.row].text5
        
        
        cell.userImageView.kf.setImage(with: URL(string: userImageUrl), placeholder: UIImage(named: "placeholder.jpg"))

//                cell.commentTextView.text = posts[indexPath.row].text
                let imageUrl = posts[indexPath.row].imageUrl
                cell.photoImageView.kf.setImage(with: URL(string: imageUrl))

                // Likeによってハートの表示を変える
                if posts[indexPath.row].isLiked == true {
                    cell.likeButton.setImage(UIImage(named: "hearts@2x.png"), for: .normal)
                } else {
                    cell.likeButton.setImage(UIImage(named: "Heart@2x.png"), for: .normal)
                }

                // Likeの数
                //cell.likeCountLabel.text = "\(posts[indexPath.row].likeCount)件"

                // タイムスタンプ(投稿日時) (※フォーマットのためにSwiftDateライブラリをimport)
//                cell.timestampLabel.text = posts[indexPath.row].createDate.string()
        return cell
        
        
    }
    func didTapLikeButton(tableViewCell: UITableViewCell, button: UIButton) {
        
        //NCMB.current()が本当に空にならないように例外処理を書くこと
        guard let currentUser = NCMBUser.current() else {
            
            //ログインに戻る
            //nil だった場合に戻ること
            //ログイン画面に戻したいから
         
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationcontroller")
            //このアプリの一番下のデータを取得することができる
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            //ログイン状態の保持
            let ud = UserDefaults.standard
           //false = ログインしていない
            ud.setValue(false, forKey:"islogin")
            ud.synchronize()
            return
        }
        

          if posts[tableViewCell.tag].isLiked == false || posts[tableViewCell.tag].isLiked == nil {
              let query = NCMBQuery(className: "Post")
            
            //POSTと同時にユーザーの情報もとってくる
            query?.includeKey("user")
              query?.getObjectInBackground(withId: posts[tableViewCell.tag].objectId, block: { (post, error) in
                  post?.addUniqueObject(currentUser.objectId, forKey: "likeUser")
                  post?.saveEventually({ (error) in
                      if error != nil {
//                          SVProgressHUD.showError(withStatus: error!.localizedDescription)
                      } else {
                          self.loadTimeline()
                      }
                  })
              })
          } else {
              let query = NCMBQuery(className: "Post")
              query?.getObjectInBackground(withId: posts[tableViewCell.tag].objectId, block: { (post, error) in
                  if error != nil {
//                      SVProgressHUD.showError(withStatus: error!.localizedDescription)
                  } else {
                      post?.removeObjects(in: [currentUser.objectId], forKey: "likeUser")
                      post?.saveEventually({ (error) in
                          if error != nil {
//                              SVProgressHUD.showError(withStatus: error!.localizedDescription)
                          } else {
                              self.loadTimeline()
                          }
                      })
                  }
              })
          }
      }
    func didTapMenuButton(tableViewCell: UITableViewCell, button: UIButton) {
         let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let reportAction = UIAlertAction(title: "報告する", style: .destructive) { (action) in
//             SVProgressHUD.showSuccess(withStatus: "この投稿を報告しました。ご協力ありがとうございました。")
        }
       
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        let deleteAction = UIAlertAction(title: "削除する", style: .destructive) { (action) in
//             SVProgressHUD.show()
            let query = NCMBQuery(className: "Post")
            query?.getObjectInBackground(withId: self.posts[tableViewCell.tag].objectId, block: { (post, error) in
                if error != nil {
//                     SVProgressHUD.showError(withStatus: error!.localizedDescription)
                } else {
                    // 取得した投稿オブジェクトを削除
                    post?.deleteInBackground({ (error) in
                        if error != nil {
//                             SVProgressHUD.showError(withStatus: error!.localizedDescription)
                        } else {
                            // 再読込
                            self.loadTimeline()
//                             SVProgressHUD.dismiss()
                        }
                    })
                }
            })
        }
        if posts[tableViewCell.tag].user.objectId == NCMBUser.current().objectId {
            // 自分の投稿なので、削除ボタンを出す
            alertController.addAction(deleteAction)
        } else {
            // 他人の投稿なので、報告ボタンを出す
            alertController.addAction(reportAction)
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

    }

        
        func loadTimeline() {
            //NCMB.current()が本当に空にならないように例外処理を書くこと
            guard let currentUser = NCMBUser.current() else {
                
                //ログインに戻る
                //nil だった場合に戻ること
                //ログイン画面に戻したいから
             
                let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationcontroller")
                //このアプリの一番下のデータを取得することができる
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                //ログイン状態の保持
                let ud = UserDefaults.standard
               //false = ログインしていない
                ud.setValue(false, forKey:"islogin")
                ud.synchronize()
                return
            
            }
            //query = 仕様書　検索の要件をまとめる
            //classnameで撮ってくる場所を指定する
            
            
                let query = NCMBQuery(className: "Post")

                // 降順
                query?.order(byDescending: "createDate")

                // 投稿したユーザーの情報も同時取得
            //includekeyでそれ以外のメールアドレスなどの情報を取ってくる
                query?.includeKey("user")

                // フォロー中の人 + 自分の投稿だけ持ってくる
                    // query?.whereKey("user", containedIn: followings)

                // オブジェクトの取得
            //上の仕様書の’内容をもとにNCMBの情報を取ってくる
            //取ってきた後は237に書いてある
                query?.findObjectsInBackground({ (result, error) in
                    if error != nil {
//                        SVProgressHUD.showError(withStatus: error!.localizedDescription)
                    } else {
                        // 投稿を格納しておく配列を初期化(これをしないとreload時にappendで二重に追加されてしまう)
                        self.posts = [Post]()
                        print(result)

                        for postObject in result as! [NCMBObject] {
                            // ユーザー情報をUserクラスにセット
                            let user = postObject.object(forKey: "user") as! NCMBUser

                            // 退会済みユーザーの投稿を避けるため、activeがfalse以外のモノだけを表示
                            if user.object(forKey: "active") as? Bool != false {
                                // 投稿したユーザーの情報をUserモデルにまとめる
                                let userModel = User(objectId: user.objectId, userName: user.userName)
                                userModel.displayName = user.object(forKey: "displayName") as? String

                                // 投稿の情報を取得
                                let imageUrl = postObject.object(forKey: "imageUrl") as! String
                                let text1 = postObject.object(forKey: "text1") as! String
                                let text2 = postObject.object(forKey: "text2") as! String
                                let text3 = postObject.object(forKey: "text3") as! String
                                let text4 = postObject.object(forKey: "text4") as! String
                                let text5 = postObject.object(forKey: "text5") as! String

                                // 2つのデータ(投稿情報と誰が投稿したか?)を合わせてPostクラスにセット
                                let post = Post(objectId: postObject.objectId, user: userModel, imageUrl: imageUrl, text1: text1,text2: text2, text3: text3, text4: text4, text5: text5, createDate: postObject.createDate)

                                // likeの状況(自分が過去にLikeしているか？)によってデータを挿入
                                let likeUsers = postObject.object(forKey: "likeUser") as? [String]
                                if likeUsers?.contains(currentUser.objectId) == true {
                                    post.isLiked = true
                                } else {
                                    post.isLiked = false
                                }

                                // いいねの件数
                                if let likes = likeUsers {
                                    post.likeCount = likes.count
                                }

                                // 配列に加える
                                self.posts.append(post)
                            }
                        }

                        // 投稿のデータが揃ったらTableViewをリロード
                        self.timeLineTableView.reloadData()
                    }
                })
            }
        
        func loadFollowingUsers() {
                // フォロー中の人だけ持ってくる
                let query = NCMBQuery(className: "Follow")
                query?.includeKey("user")
                query?.includeKey("following")
                query?.whereKey("user", equalTo: NCMBUser.current())
                query?.findObjectsInBackground({ (result, error) in
                    if error != nil {
//                        SVProgressHUD.showError(withStatus: error!.localizedDescription)
                    } else {
                        self.followings = [NCMBUser]()
                        for following in result as! [NCMBObject] {
                            self.followings.append(following.object(forKey: "following") as! NCMBUser)
                        }
                        self.followings.append(NCMBUser.current())

                        self.loadTimeline()
                    }
                })
            }
    
        func setRefreshControl() {
               let refreshControl = UIRefreshControl()
               refreshControl.addTarget(self, action: #selector(reloadTimeline(refreshControl:)), for: .valueChanged)
               timeLineTableView.addSubview(refreshControl)
           }

    @objc func reloadTimeline(refreshControl: UIRefreshControl) {
               refreshControl.beginRefreshing()
               self.loadFollowingUsers()
               // 更新が早すぎるので2秒遅延させる
               DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                   refreshControl.endRefreshing()
               }
           }
    
    @IBAction func dropput(){
        
        
     }
    
   
    
    var TimeLineArray = [String]()
    @IBOutlet var Tableview: UITableView!

    
    
   

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toComments" {
//               let commentViewController = segue.destination as! CommentViewController
//               commentViewController.postId = selectedPost?.objectId
           }
       }


}

