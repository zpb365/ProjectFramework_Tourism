//
//  MyRelease.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyRelease: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    let identiFier = "MyReleaseCell"
    var dataArray = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的发布"
        
        // Do any additional setup after loading the view.
        self.initUI()
        self.getData(count: 15)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: getData
    func getData(count : Int) -> Void {
        for i in 0..<count{
            dataArray.append(String(i))
        }
        tableView.reloadData()
    }
    //MARK: initUI
    func initUI() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight)
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        self.tableView.isEditing = true
        self.tableView.tableFooterView = UIView.init()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath)as! MyReleaseCell
        return cell
    }
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
