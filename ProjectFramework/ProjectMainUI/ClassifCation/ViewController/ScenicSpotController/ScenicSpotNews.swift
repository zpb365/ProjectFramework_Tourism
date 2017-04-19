//
//  ScenicSpotNews.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotNews: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    let identifier = "ScenicSpotHomeNewsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initUI() -> Void {
        tableView.register(UINib(nibName: "ScenicSpotHomeNewsCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.InitCongif(self.tableView)
        self.numberOfSections = 1
        self.numberOfRowsInSection = 10
        self.tableViewheightForRowAt = 35
        self.tableView.frame = self.view.bounds
        self.tableView.tableHeaderView = UIView().headView(width: CommonFunction.kScreenWidth, height: 35, leftViewColor: UIColor().TransferStringToColor("#00ABEE"), title: "景区公告", titleColor: UIColor.black)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScenicSpotHomeNewsCell
        return cell

    }
}
