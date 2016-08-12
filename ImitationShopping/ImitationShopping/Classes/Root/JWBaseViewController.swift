//
//  JWBaseViewController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWBaseViewController: UIViewController {

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = JWColor(240, g: 240, b: 240, a: 1)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
}
