//
//  JWHomeController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit
import SnapKit
import VTMagic

class JWHomeController: VTMagicController {

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.magicView.navigationColor = JWColor(240, g: 240, b: 240, a: 1)
        self.magicView.layoutStyle = VTLayoutStyle.Divide
        
        self.queryMenuRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var menuTitls = [String]()
    var menuModles = [JWMenuModle]()
    // MARK:- Private Method
 
    
    // MARK:- Request
    func queryMenuRequest() -> Void {
        
        JWServiceManager.shareInstance().requestMenuData { [weak self] (menuList) in
            
            self?.menuModles = menuList
            for tempMenu in menuList {
                self!.menuTitls.append(tempMenu.menuName!)
            }
            self!.magicView.reloadData()
        }
    }
}

extension JWHomeController {
    
    // MARK:- VTMagicViewDelegate & VTMagicViewDataSource
    override func menuTitlesForMagicView(magicView: VTMagicView) -> [String] {
        return menuTitls
    }
    
    override func magicView(magicView: VTMagicView, menuItemAtIndex itemIndex: UInt) -> UIButton {
        var item = magicView.dequeueReusableItemWithIdentifier("JWHomeControllerMenuItemIdentifier")
        if (item == nil) {
            item = UIButton()
            item?.setTitleColor(JWColor(50, g: 50, b: 50, a: 1), forState: UIControlState.Normal)
            item?.setTitleColor(JWColor(169, g: 37, b: 37, a: 1), forState: UIControlState.Highlighted)
            item?.titleLabel?.font = UIFont.systemFontOfSize(16)
        }
        return item!
    }
    
    override func magicView(magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController {
        
        var controller = magicView.dequeueReusablePageWithIdentifier("JWHomeControllerMenuControllerIdentifier") as? JWHomeDataController
        
        if controller == nil {
            controller = JWHomeDataController()
            controller!.menuModle = self.menuModles[Int(pageIndex)]
        }
        
        return controller!
    }
}
