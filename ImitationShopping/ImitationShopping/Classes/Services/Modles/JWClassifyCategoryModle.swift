//
//  JWClassifyCategoryModle.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/11.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import Foundation

class JWClassifyCategoryModle: NSObject {

    var jwc_categoryID: Int?
    var jwc_categoryStatus: Int?
    var jwc_categoryTitle: String?
    var jwc_categorySubtitle: String?
    var jwc_categoryBannerImageURL: String?
    var jwc_categoryCoverImageURL: String?
    var jwc_categoryPostCount: Int?
    var jwc_categoryCreateDate: Int?
    var jwc_categoryUpdateDate: Int?
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        jwc_categoryID = dict["id"] as? Int
        jwc_categoryStatus = dict["status"] as? Int
        jwc_categoryTitle = dict["title"] as? String
        jwc_categorySubtitle = dict["subtitle"] as? String
        jwc_categoryBannerImageURL = dict["banner_image_url"] as? String
        jwc_categoryCoverImageURL = dict["cover_image_url"] as? String
        jwc_categoryPostCount = dict["posts_count"] as? Int
        jwc_categoryCreateDate = dict["created_at"] as? Int
        jwc_categoryUpdateDate = dict["updated_at"] as? Int
    }
}
