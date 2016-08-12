//
//  JWClassifyGroupModle.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/11.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import Foundation

class JWClassifyGroupModle: NSObject {

    var jwc_groupID: Int?
    var jwc_groupStatus: Int?
    var jwc_groupChannels: [JWCGChannelModle]?
    var jwc_groupOrder: Int?
    var jwc_groupName: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        jwc_groupID = dict["id"] as? Int
        jwc_groupStatus = dict["status"] as? Int
        jwc_groupOrder = dict["order"] as? Int
        jwc_groupName = dict["name"] as? String

        var tempChannels = [JWCGChannelModle]()
        let tempChannelArray = dict["channels"] as? [[String: AnyObject]]
        for tempChannelDic in tempChannelArray! {
            let tempChannel = JWCGChannelModle(dict: tempChannelDic)
            tempChannels.append(tempChannel)
        }
        jwc_groupChannels = tempChannels
    }
}

class JWCGChannelModle: NSObject {
    
    var jwcg_ID: Int?
    var jwcg_channelID: Int?
    var jwcg_channelStatus: Int?
    var jwcg_channelCount: Int?
    var jwcg_channelOrder: Int?
    var jwcg_channelName: String?
    var jwcg_channelImageURL: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        jwcg_ID = dict["id"] as? Int
        jwcg_channelID = dict["group_id"] as? Int
        jwcg_channelStatus = dict["status"] as? Int
        jwcg_channelCount = dict["items_count"] as? Int
        jwcg_channelOrder = dict["order"] as? Int
        jwcg_channelName = dict["name"] as? String
        jwcg_channelImageURL = dict["icon_url"] as? String
    }
    
}
