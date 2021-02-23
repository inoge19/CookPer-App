//
//  User.swift
//  COOking app
//
//  Created by 井上げんき on 2020/11/11.
//

import UIKit

//userの箱を作っているところ
class User: NSObject {
    
    var objectId: String
    var userName: String
    var displayName: String?
    var introduction: String?
    

    init(objectId: String, userName: String){
        
        self.objectId = objectId
        self.userName = userName
 
    }
    
    
    

}
