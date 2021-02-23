//
//  Post.swift
//  COOking app
//
//  Created by 井上げんき on 2020/11/11.
//

import UIKit
//箱を作っておるところ


class Post: NSObject {
    var objectId: String
    var user: User
    var imageUrl: String
    var text1: String
    var text2: String
    var text3: String
    var text4: String
    var text5: String
    
    var createDate: Date
    var isLiked: Bool?
//    var comments: [comment]?
    var likeCount: Int = 0
    

    init(objectId: String, user: User, imageUrl: String, text1: String, text2: String, text3: String, text4: String, text5: String, createDate: Date){
        
        self.objectId = objectId
        self.user = user
        self.imageUrl = imageUrl

        self.text1 = text1
        self.text2 = text2
        self.text3 = text3
        self.text4 = text4
        self.text5 = text5
        self.createDate = createDate
    
        
    
    }
    
    
    

}
