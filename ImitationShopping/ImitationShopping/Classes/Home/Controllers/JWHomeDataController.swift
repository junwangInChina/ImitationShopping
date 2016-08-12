//
//  JWHomeDataController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/12.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWHomeDataController: JWBaseViewController {

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(homeTableView)
        homeTableView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsZero)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    var menuModle: JWMenuModle? {
        didSet {
            
            JWServiceManager.shareInstance().requestHomeDataMenu(menuModle!) { (homeList) in
                self.homeItems = homeList
                self.homeTableView.reloadData()
            }
        }
    }
    
    var homeItems = [JWHomeItemModle]()
    
    // MARK:- Lazy loading
    private lazy var homeTableView: UITableView = {
        let tempTableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.registerClass(JWHDataCell.self, forCellReuseIdentifier: "JWHomeDataControllerCellIdentifier")
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tempTableView.rowHeight = 150
        tempTableView.contentInset = UIEdgeInsetsMake(JW_MARGIN/2, 0, 0, 0)
        
        return tempTableView
    }()
}

extension JWHomeDataController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeItems.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JWHomeDataControllerCellIdentifier", forIndexPath: indexPath) as! JWHDataCell
        
        cell.itemModle = self.homeItems[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let item = self.homeItems[indexPath.row]
        let detailController = JWCLDetailController()
        detailController.homeItem = item
        navigationController?.pushViewController(detailController, animated: true)
    }
}
