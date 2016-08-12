//
//  JWCommentModle.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import Foundation

class JWCommentModle: NSObject {
    
    var comment_ID: Int?
    var comment_content: String?
    var comment_create_at: Int?
    var comment_item_id: Int?
    var comment_show: Bool?
    var comment_user: JWUserModle?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        comment_ID = dict["id"] as? Int
        comment_content = dict["content"] as? String
        comment_create_at = dict["created_at"] as? Int
        comment_item_id = dict["item_id"] as? Int
        comment_show = dict["show"] as? Bool
        comment_user = JWUserModle(dict: dict["user"] as! [String: AnyObject])
    }
}
