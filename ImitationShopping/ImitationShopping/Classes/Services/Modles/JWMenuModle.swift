//
//  JWMenuModle.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import Foundation

class JWMenuModle: NSObject {

    var menuEditable: Bool?
    var menuID: NSInteger?
    var menuName: String?
    
    init(dic: [String: AnyObject]) {
        menuID = dic["id"] as? NSInteger
        menuName = dic["name"] as? String
        menuEditable = dic["editable"] as? Bool
    }
}
