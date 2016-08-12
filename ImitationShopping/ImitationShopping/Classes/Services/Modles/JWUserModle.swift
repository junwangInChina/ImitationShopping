//
//  JWUserModle.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import Foundation

class JWUserModle: NSObject {

    var user_ID: Int?
    var user_avatr_url: String?
    var user_nickname: String?
    var user_role: Int?
    var user_can_mobile_login: Bool?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        user_ID = dict["id"] as? Int
        user_avatr_url = dict["avatar_url"] as? String
        user_nickname = dict["nickname"] as? String
        user_role = dict["role"] as? Int
        user_can_mobile_login = dict["can_mobile_login"] as? Bool
    }
}
