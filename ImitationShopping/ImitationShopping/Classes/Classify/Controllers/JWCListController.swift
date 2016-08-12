//
//  JWCListController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/12.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWCListController: JWBaseViewController {

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.listTableView)
        self.listTableView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!.view).offset(UIEdgeInsetsZero)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    var items = [JWCLItemModle]()
    
    var category: JWClassifyCategoryModle? {
        didSet {
            
            self.title = category!.jwc_categoryTitle
            
            JWServiceManager.shareInstance().requestClassifyItemsWithCategory(category!) { [weak self] (itemList) in
                self!.items = itemList
                self!.listTableView.reloadData()
            }
        }
    }
    
    var channel: JWCGChannelModle? {
        didSet {
            
            self.title = channel!.jwcg_channelName
            
            JWServiceManager.shareInstance().requestClassifyItemsWithChannel(channel!) { [weak self] (itemList) in
                self!.items = itemList
                self!.listTableView.reloadData()
            }
        }
    }
    
    // MARK:- Lazy loading
    private lazy var listTableView: UITableView = {
        let tempTableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.registerClass(JWCLItemCell.self, forCellReuseIdentifier: "JWCListControllerItemCellIdentifier")
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tempTableView.rowHeight = 150
        tempTableView.contentInset = UIEdgeInsetsMake(JW_MARGIN/2, 0, 0, 0)
        
        return tempTableView
    }()
    
}

extension JWCListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JWCListControllerItemCellIdentifier", forIndexPath: indexPath) as! JWCLItemCell
        
        cell.item = self.items[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let item = self.items[indexPath.row]
        let detailController = JWCLDetailController()
        detailController.item = item
        navigationController?.pushViewController(detailController, animated: true)
    }
}
