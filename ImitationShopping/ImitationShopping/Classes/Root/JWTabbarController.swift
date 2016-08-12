//
//  JWTabbarController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWTabbarController: UITabBarController {

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = UIColor(red: 245 / 255, green: 80 / 255, blue: 83 / 255, alpha: 1.0)
        
        self.addChildControllers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Private Method
    func addChildControllers() -> Void {
        addChildController("JWHomeController", title: "首页", imageName: "TabBar_home")
        addChildController("JWProductController", title: "单品", imageName: "TabBar_product")
        addChildController("JWClassifyController", title: "分类", imageName: "TabBar_classify")
        addChildController("JWMineController", title: "我的", imageName: "TabBar_mine")
    }
    
    private func addChildController(childControllerName: String,
                                    title: String,
                                    imageName: String) -> Void {
        
        // 根据Controller的Name，获取到对应的Controller对象
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let className:AnyClass = NSClassFromString(nameSpace + "." + childControllerName)!
        let controllerClass = className as! UIViewController.Type
        let childController = controllerClass.init()
        
        childController.tabBarItem.image = UIImage.init(named: imageName)
        childController.tabBarItem.selectedImage = UIImage.init(named: imageName + "seleted")
        childController.title = title
        let childNav = JWNavigationController()
        childNav.addChildViewController(childController)
        addChildViewController(childNav)
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















