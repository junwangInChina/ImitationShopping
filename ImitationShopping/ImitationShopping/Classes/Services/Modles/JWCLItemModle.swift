//
//  JWCLItemModle.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/12.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import Foundation

class JWCLItemModle: NSObject {

    var itemID: Int?
    var itemCoverImageURL: String?
    var itemContentURL: String?
    var itemURL: String?
    var itemTitle: String?
    var itemShortTitle: String?
    var itemShareMsg: String?
    var itemCreateAt: Int?
    var itemPublishedAt: Int?
    var itemUpdateAt: Int?
    var itemLiked: Bool?
    var itemLikeCount: Int?
    var itemStatus: Int?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        itemID = dict["id"] as? Int
        itemCoverImageURL = dict["cover_image_url"] as? String
        itemContentURL = dict["content_url"] as? String
        itemURL = dict["url"] as? String
        itemTitle = dict["title"] as? String
        itemShortTitle = dict["short_title"] as? String
        itemShareMsg = dict["share_msg"] as? String
        itemCreateAt = dict["created_at"] as? Int
        itemPublishedAt = dict["published_at"] as? Int
        itemUpdateAt = dict["updated_at"] as? Int
        itemLiked = dict["liked"] as? Bool
        itemLikeCount = dict["likes_count"] as? Int
        itemStatus = dict["status"] as? Int
    }
}
