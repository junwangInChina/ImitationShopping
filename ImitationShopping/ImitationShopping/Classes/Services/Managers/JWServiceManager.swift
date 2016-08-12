//
//  JWServiceManager.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JWServiceManager: NSObject {

    // 单利模式
    //static let manager = JWServiceManager()
    
    // 单利模式（两种单利模式，任选一种即可）
    static var once: dispatch_once_t = 0
    static var manager: JWServiceManager?
    class func shareInstance() -> JWServiceManager {
        dispatch_once(&once) { () -> Void in
            manager = JWServiceManager()
        }
        return manager!
    }
    
    /**
     # 获取菜单数据
     
     - parameter finished: 用于回调请求的代码块
     */
    func requestMenuData(finished:(menuList: [JWMenuModle]) -> ()) -> Void {
        
        let url = JW_BASE_SERVICE + "v2/channels/preset"
        let params = ["gender":1,
                      "generation":1]
        
        Alamofire
            .request(.GET,
                     url,
                     parameters: params,
                     encoding: .URL,
                     headers: nil)
            .responseJSON { (response) in
            
                guard response.result.isSuccess else {
                    print("获取菜单数据接口请求失败")
                    return
                }
                
                if let responseValue = response.result.value {
                    let responseDic = JSON(responseValue)
                    let responseCode = responseDic["code"].intValue
                    let responseMessage = responseDic["message"].stringValue
                    guard responseCode == JW_SERVICE_SUCCESS_CODE else {
                        print("请求失败 \n错误码为%d \n错误为:%@错误数据为:%@ \n",responseCode,responseMessage,responseDic)
                        return
                    }
                    let responseData = responseDic["data"].dictionary
                    print("请求成功，完成数据为%@",responseData)
                    if let tempDicArray = responseData!["channels"]?.arrayObject {
                        var tempModleArray = [JWMenuModle]()
                        
                        for tempDic in tempDicArray {
                            let tempModel = JWMenuModle.init(dic: tempDic as! [String:AnyObject])
                            tempModleArray.append(tempModel)
                        }
                        finished(menuList: tempModleArray)
                    }
                }
        }
    }
    
    func requestHomeDataMenu(menu: JWMenuModle, finished:(homeList: [JWHomeItemModle]) -> ()) -> Void {
        
        let url = JW_BASE_SERVICE + "v1/channels/\(menu.menuID!)/items"
        let param = ["gender": 1,
                     "generation": 1,
                     "limit": 20,
                     "offset": 0]
        
        Alamofire
            .request(.GET, url, parameters: param, encoding: .URL, headers: nil)
            .responseJSON { (response) in
            
                guard response.result.isSuccess else {
                    print("获取首页数据接口请求失败")
                    return
                }
                
                if let responseValue = response.result.value {
                    let responseDic = JSON(responseValue)
                    let responseCode = responseDic["code"].intValue
                    let responseMessage = responseDic["message"].stringValue
                    guard responseCode == JW_SERVICE_SUCCESS_CODE else {
                        print("请求失败 \n错误码为%d \n错误为:%@错误数据为:%@ \n",responseCode,responseMessage,responseDic)
                        return
                    }
                    if let responseData = responseDic["data"].dictionary {
                        print("请求成功，完成数据为%@",responseData)
                        if let itemArray = responseData["items"]?.arrayObject {
                            var items = [JWHomeItemModle]()
                            for itemDic in itemArray {
                                let itemModle = JWHomeItemModle(dict: itemDic as! [String: AnyObject])
                                items.append(itemModle)
                            }
                            finished(homeList: items)
                        }
                    }
                }
        }
    }
    
    /**
     获取商品数据
     
     - parameter finished: 回调的代码块
     */
    func requestProductData(finished:(productList: [JWProductModle]) -> ()) -> Void {
        
        let url = JW_BASE_SERVICE + "v2/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params, encoding: .URL, headers: nil)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("获取商品数据接口请求失败")
                    return
                }
                if let responseValue = response.result.value {
                    let responseDic = JSON(responseValue)
                    let responseCode = responseDic["code"].intValue
                    let responseMessage = responseDic["message"].stringValue
                    guard responseCode == JW_SERVICE_SUCCESS_CODE else {
                        print("请求失败 \n错误码为%d \n错误为:%@错误数据为:%@ \n",responseCode,responseMessage,responseDic)
                        return
                    }
                    if let responseData = responseDic["data"].dictionary {
                        print("请求成功，完成数据为%@",responseData)
                        if let responseItems = responseData["items"]?.arrayObject {
                            var products = [JWProductModle]()
                            for item in responseItems {
                                if let itemData = item["data"] {
                                    let product = JWProductModle(dict: itemData as! [String: AnyObject])
                                    products.append(product)
                                }
                            }
                            finished(productList: products)
                        }
                    }
                }
        }
    }
    
    /**
     获取商品详情
     
     - parameter productID: 商品ID
     - parameter finished:  回调的代码块
     */
    func requestProductDetail(productID: Int, finished:(prodtctDetail: JWProductModle) -> ()) -> Void {
        
        let url = JW_BASE_SERVICE + "v2/items/\(productID)"
        Alamofire
            .request(.GET, url, parameters: nil, encoding: .URL, headers: nil)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("获取商品详情请求失败")
                    return
                }
                if let responseValue = response.result.value {
                    let responseDic = JSON(responseValue)
                    let responseCode = responseDic["code"].intValue
                    let responseMessage = responseDic["message"].stringValue
                    guard responseCode == JW_SERVICE_SUCCESS_CODE else {
                        print("请求失败 \n错误码为%d \n错误为:%@错误数据为:%@ \n",responseCode,responseMessage,responseDic)
                        return
                    }
                    
                    if let responseData = responseDic["data"].dictionaryObject {
                        print("请求成功，完成数据为%@",responseData)
                        let productDetail = JWProductModle(dict:responseData)
                        
                        finished(prodtctDetail: productDetail)
                    }
                }
        }
    }
    
    /**
     获取商品评论列表
     
     - parameter productId: 商品ID
     - parameter finished:  回调的代码块
     */
    func requestProductComments(productId: Int, finished:(commentList: [JWCommentModle]) -> ()) -> Void {
    
        let url = JW_BASE_SERVICE + "v2/items/\(productId)/comments"
        let params = ["limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params, encoding: .URL, headers: nil)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("获取商品详情请求失败")
                    return
                }
                if let responseValue = response.result.value {
                    let responseDic = JSON(responseValue)
                    let responseCode = responseDic["code"].intValue
                    let responseMessage = responseDic["message"].stringValue
                    guard responseCode == JW_SERVICE_SUCCESS_CODE else {
                        print("请求失败 \n错误码为%d \n错误为:%@错误数据为:%@ \n",responseCode,responseMessage,responseDic)
                        return
                    }
                    if let responseData = responseDic["data"].dictionary {
                        print("请求成功，完成数据为%@",responseData)
                        if let commentData = responseData["comments"]?.arrayObject {
                            var comments = [JWCommentModle]()
                            for item in commentData {
                                let comment = JWCommentModle(dict: item as! [String: AnyObject])
                                comments.append(comment)
                            }
                            finished(commentList: comments)
                        }
                    }
                }
        }
    }
    
    /**
     获取分类界面的顶部分类
     
     - parameter limit:    分类数
     - parameter finished: 回调代码块
     */
    func requestClassifyCategorys(limit: Int, finished:(categoryList: [JWClassifyCategoryModle]) -> ()) -> Void {
        
        let url = JW_BASE_SERVICE + "v1/collections"
        let param = ["limit":limit,"offset":0]
        
        Alamofire
            .request(.GET, url, parameters: param, encoding: .URL, headers: nil)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    print("获取分类界面顶部分类失败")
                    return
                }
                if let responseValue = response.result.value {
                    let responseDic = JSON(responseValue)
                    let responseCode = responseDic["code"].intValue
                    let responseMessage = responseDic["message"].stringValue
                    
                    guard responseCode == JW_SERVICE_SUCCESS_CODE else {
                        print("请求失败 \n错误码为%d \n错误为:%@错误数据为:%@ \n",responseCode,responseMessage,responseDic)
                        return
                    }
                    
                    if let responseData = responseDic["data"].dictionary {
                        print("请求成功，完成数据为%@",responseData)
                        if let tempCategoryArray = responseData["collections"]?.arrayObject {
                            var categorys = [JWClassifyCategoryModle]()
                            for tempCategoryDic in tempCategoryArray {
                                let tempCategoryModle = JWClassifyCategoryModle(dict: tempCategoryDic as! [String: AnyObject])
                                categorys.append(tempCategoryModle)
                            }
                            finished(categoryList: categorys)
                        }
                    }
                }
        }
    }
    
    func requestClassifyGroups(finished:(groupList: [JWClassifyGroupModle]) -> ()) -> Void {
        
        let url = JW_BASE_SERVICE + "v1/channel_groups/all"
        
        Alamofire
            .request(.GET, url, parameters: nil, encoding: .URL, headers: nil)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    print("获取分类界面底部类别失败")
                    return
                }
                if let responseValue = response.result.value {
                    let responseDic = JSON(responseValue)
                    let responseCode = responseDic["code"].intValue
                    let responseMessage = responseDic["message"].stringValue
                    guard responseCode == JW_SERVICE_SUCCESS_CODE else {
                        print("请求失败 \n错误码为%d \n错误为:%@错误数据为:%@ \n",responseCode,responseMessage,responseDic)
                        return
                    }
                    
                    if let responseData = responseDic["data"].dictionary{
                        print("请求成功，完成数据为%@",responseData)
                        // 最外层的二维数组，包含两个里层数组，里层数组里包含JWClassifyGroupModle对象
                        if let tempOutGroupsArray = responseData["channel_groups"]?.arrayObject {
                            
                            var groups = [JWClassifyGroupModle]()
                            for tempGroupDic in tempOutGroupsArray {
                                let tempModle = JWClassifyGroupModle(dict: tempGroupDic as! [String: AnyObject])
                                groups.append(tempModle)
                            }
                            finished(groupList: groups)
                            /*
                            var groups = [AnyObject]()
                            for tempInGroupArray in tempOutGroupsArray {
                                var inGroups = [JWClassifyGroupModle]()
                                let tempInGroupList = tempInGroupArray["channels"] as! [AnyObject]
                                for tempInGroupDic in tempInGroupList {
                                    let tempGroupModle = JWClassifyGroupModle(dict: tempInGroupDic as! [String: AnyObject])
                                    inGroups.append(tempGroupModle)
                                }
                                groups.append(inGroups)
                            }
                            finished(groupList: groups)
                            */
                        }
                    }
                }
        }
    }
    
    func requestClassifyItemsWithCategory(category: JWClassifyCategoryModle,
                                          finished: (itemList: [JWCLItemModle]) -> ()) -> Void {
        let url = JW_BASE_SERVICE + "v1/collections/\(category.jwc_categoryID!)/posts"
        let param = ["gender": 1,
                     "generation": 1,
                     "limit": 20,
                     "offset": 0]
        Alamofire
            .request(.GET, url, parameters: param, encoding: .URL, headers: nil)
            .responseJSON { (response) in
            
                guard response.result.isSuccess else {
                    print("获取分类界面顶部类别详细列表失败")
                    return
                }
                if let responseValue = response.result.value {
                    let responseDic = JSON(responseValue)
                    let responseCode = responseDic["code"].intValue
                    let responseMessage = responseDic["message"].stringValue
                    guard responseCode == JW_SERVICE_SUCCESS_CODE else {
                        print("请求失败 \n错误码为%d \n错误为:%@错误数据为:%@ \n",responseCode,responseMessage,responseDic)
                        return
                    }
                    if let responseData = responseDic["data"].dictionary {
                        print("请求成功，完成数据为%@",responseData)
                        if let tempArray = responseData["posts"]?.arrayObject {
                            var items = [JWCLItemModle]()
                            for itemDic in tempArray {
                                let tempItem = JWCLItemModle(dict: itemDic as! [String: AnyObject])
                                items.append(tempItem)
                            }
                            finished(itemList: items)
                        }
                    }
                }
        }
    }
    
    func requestClassifyItemsWithChannel(channel: JWCGChannelModle,
                                         finished: ((itemList: [JWCLItemModle]) -> ())) -> Void {
        let url = JW_BASE_SERVICE + "v1/channels/\(channel.jwcg_ID!)/items"
        let param = ["limit": 20,
                     "offset": 0]
        
        Alamofire
            .request(.GET, url, parameters: param, encoding: .URL, headers: nil)
            .responseJSON { (response) in
            
                guard response.result.isSuccess else {
                    print("获取分类界面底部类别详细列表失败")
                    return
                }
                if let responseValue = response.result.value {
                    let responseDic = JSON(responseValue)
                    let responseCode = responseDic["code"].intValue
                    let responseMessage = responseDic["message"].stringValue
                    guard responseCode == JW_SERVICE_SUCCESS_CODE else {
                        print("请求失败 \n错误码为%d \n错误为:%@错误数据为:%@ \n",responseCode,responseMessage,responseDic)
                        return
                    }
                    if let responseData = responseDic["data"].dictionary {
                        print("请求成功，完成数据为%@",responseData)
                        if let tempArray = responseData["items"]?.arrayObject {
                            var items = [JWCLItemModle]()
                            for itemDic in tempArray {
                                let tempItem = JWCLItemModle(dict: itemDic as! [String: AnyObject])
                                items.append(tempItem)
                            }
                            finished(itemList: items)
                        }
                    }
                }
        }
    }
}















