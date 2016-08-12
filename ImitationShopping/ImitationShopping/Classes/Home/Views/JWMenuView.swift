//
//  JWMenuView.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWMenuView: UIView {

    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.menuScrollView)
        self.menuScrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Lazy loading
    lazy var menuScrollView: UIScrollView = {
        let tempScrollView = UIScrollView()
        tempScrollView.alwaysBounceVertical = false
        tempScrollView.alwaysBounceHorizontal = false
        
        return tempScrollView
    }()
    
    var seletedMenuItem = UIButton?()
    
    // MARK:- Public Method
    func configMenuData(list:[JWMenuModle]) -> Void {
        
        if list.count <= 0 { return }
        
        var itemWidth = JW_SCREEN_WIDTH / CGFloat(list.count)
        if itemWidth < 100.0 {
            itemWidth = 100.0
        }
        
        let belowView = UIView()
        belowView.userInteractionEnabled = true
        self.menuScrollView.addSubview(belowView)
        belowView.snp_makeConstraints { (make) in
            make.edges.equalTo(menuScrollView)
        }
        
        for index in 0..<list.count {
            
            // 创建菜单选项
            let tempModel = list[index]
            let tempButton = UIButton.init()
            tempButton.setTitle(tempModel.menuName, forState: UIControlState.Normal)
            tempButton.titleLabel?.font = UIFont.systemFontOfSize(13)
            tempButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            tempButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            tempButton.addTarget(self, action: #selector(menuItemAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            belowView.addSubview(tempButton)
            
            // 默认选中第一个
            if index == 0 {
                tempButton.enabled = false
                seletedMenuItem = tempButton
            }
            
            // 菜单item排版
            /* PS
             scrollView内部子控件的尺寸不能以scrollView的尺寸为参照
             scrollView内部的子控件的约束必须完整(子控件在水平和垂直方向用约束把ContainView撑满，使containtView扩展以适合它们的尺寸。例如：以前普通布局，只需要定义宽高、左、上的距离即可，但是这时候需要把下、右的距离也补上，不然containView不知道到底尺寸多大)
             */
            tempButton.snp_makeConstraints(closure: { (make) in
                make.width.equalTo(itemWidth)
                make.height.equalTo(belowView)
                if index > 0, let preButton = self.menuScrollView.subviews[2].subviews[index-1] as? UIButton {
                    make.left.equalTo(preButton.snp_right)
                }
                else {
                    make.left.equalTo(belowView)
                }
                
                if index == (list.count - 1) {
                    belowView.snp_makeConstraints(closure: { (make) in
                        make.right.equalTo(tempButton)
                    })
                }
            })
        }
    }
    
    // MARK:- Private Method
    func menuItemAction(sender: UIButton) -> Void {
        // 重置之前选中的按钮状态
        seletedMenuItem?.enabled = true
        // 将当前点击按钮设置为选中状态
        sender.enabled = false
        // 将当前点击按钮设置为选中item
        seletedMenuItem = sender
        
    }
}
