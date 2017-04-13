//
//  MessageViewController.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MessageViewController: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    let identifier = "messageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame=CGRect(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: self.view.frame.height - CommonFunction.NavigationControllerHeight)
        self.tableViewheightForRowAt=55
        self.numberOfSections=1
        self.numberOfRowsInSection=10
        self.InitCongif(tableView) 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as! MessageViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     CommonFunction.Panorama360Show(vc: self, url: "http://chuantu.biz/t5/64/1492055415x2890174292.jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
