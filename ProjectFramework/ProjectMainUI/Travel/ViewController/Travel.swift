//
//  Travel.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/23.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class Travel: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    let identiFier  = "TravelCell"
    
    @IBOutlet weak var headView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //基控制器
        self.InitCongif(tableView)
        self.tableView.tableHeaderView = headView
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: self.view.frame.height-CommonFunction.NavigationControllerHeight)
        self.numberOfRowsInSection=10//显示的个数
        self.numberOfSections=1//显示行数
        self.tableViewheightForRowAt=170//行高
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! TravelCell
        return cell
        
    }
}
