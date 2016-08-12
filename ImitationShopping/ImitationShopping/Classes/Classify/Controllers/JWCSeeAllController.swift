//
//  JWCSeeAllController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/12.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWCSeeAllController: JWBaseViewController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "查看全部"
        
        self.view.addSubview(self.categoryTableView)
        self.categoryTableView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsZero)
        }
        
        self.requestAllCategorys()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    // MARK: - Lazy loading
    private lazy var categoryTableView: UITableView = {
        let tempTableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.registerClass(JWCSeeAllCell.self, forCellReuseIdentifier: "JWCSeeAllControllerCategoryCellIdentifier")
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tempTableView.rowHeight = 150
        tempTableView.contentInset = UIEdgeInsetsMake(JW_MARGIN/2, 0, 0, 0)
        
        return tempTableView
    }()
    
    var categorys = [JWClassifyCategoryModle]()
    
    // MARK:- Request
    func requestAllCategorys() -> Void {
        
        JWServiceManager.shareInstance().requestClassifyCategorys(20) { (categoryList) in
            self.categorys = categoryList
            self.categoryTableView.reloadData()
        }
    }
}

extension JWCSeeAllController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorys.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JWCSeeAllControllerCategoryCellIdentifier", forIndexPath: indexPath) as! JWCSeeAllCell
        
        cell.category = self.categorys[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let category = self.categorys[indexPath.row]
        let listController = JWCListController()
        listController.category = category
        navigationController?.pushViewController(listController, animated: true)
    }
}

