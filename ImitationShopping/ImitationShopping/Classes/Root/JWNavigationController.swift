//
//  JWNavigationController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal override class func initialize() {
        super.initialize()
        
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = UIColor.redColor()
        navBar.tintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                                      NSFontAttributeName: UIFont.systemFontOfSize(20)]
    }
    
    /**
     # 拦截所有页面的Push操作
     # 统一所有控制器导航栏左上角的返回按钮，让所有push进来的控制器，它的导航栏左上角的内容都一样
     
     - parameter viewController: 需要压栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        // 判断是否为根视图
        if viewControllers.count > 0 {
            
            // push到下一页面后，需要隐藏Tabbar
            viewController.hidesBottomBarWhenPushed = true
            // 添加统一的返回按钮
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Nav_back"),
                                                                                   style: UIBarButtonItemStyle.Plain,
                                                                                   target: self,
                                                                                   action: #selector(customNavBackButtonAction(_:)))
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func customNavBackButtonAction(sender: AnyObject) -> Void {
    
        if UIApplication.sharedApplication().networkActivityIndicatorVisible {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        
        popViewControllerAnimated(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
