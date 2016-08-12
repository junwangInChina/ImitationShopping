//
//  GloableDefine.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

let JW_SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
let JW_SCREEN_Height = UIScreen.mainScreen().bounds.height

/// 间距
let JW_MARGIN: CGFloat = 10.0

func JWColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
