//
//  JWProductModle.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import Foundation

class JWProductModle: NSObject {

    var product_cover_image_url: String?    // 封面图
    var product_create_at: Int?             // 创建时间
    var product_updated_at: Int?            // 修改时间
    var product_describe: String?           // 描述
    var product_editorID: Int?              // 拥有者ID
    var product_favCount: Int?              // 喜欢的数量
    var product_ID: Int?                    // 商品ID
    var product_image_URLS: [String]?       // 商品图片数组
    var product_url: String?                // 商品链接
    var product_is_fav: Bool?               // 当前用户是否已收藏（喜欢）
    var product_name: String?               // 商品名称
    var product_price: String?              // 商品价格
    
    var product_purchase_ID: Int?           // 优惠卷ID
    var product_purchase_status: Int?       // 优惠卷状态
    var product_purchase_type: Int?         // 优惠卷类型
    var product_purchase_url: String?       // 优惠卷URL
    
    var product_liked: Bool?                // 是否喜欢
    var product_detail_url: String?         // 图文详情链接
    var product_comment_count: Int?         // 评论数
    
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        product_cover_image_url = dict["cover_image_url"] as? String
        product_create_at = dict["created_at"] as? Int
        product_updated_at = dict["updated_at"] as? Int
        product_describe = dict["description"] as? String
        product_editorID = dict["editor_id"] as? Int
        product_favCount = dict["favorites_count"] as? Int
        product_ID = dict["id"] as? Int
        product_image_URLS = dict["image_urls"] as? [String]
        product_url = dict["url"] as? String
        product_is_fav = dict["is_favorite"] as? Bool
        product_name = dict["name"] as? String
        product_price = dict["price"] as? String
        
        product_purchase_ID = dict["purchase_id"] as? Int
        product_purchase_status = dict["purchase_status"] as? Int
        product_purchase_type = dict["purchase_type"] as? Int
        product_purchase_url = dict["purchase_url"] as? String
        
        product_liked = dict["liked"] as? Bool
        product_detail_url = dict["detail_html"] as? String
        product_comment_count = dict["comments_count"] as? Int
    }
}
