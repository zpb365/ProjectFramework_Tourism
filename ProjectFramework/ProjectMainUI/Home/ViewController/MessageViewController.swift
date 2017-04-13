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
        debugPrint("I click tableview:\(indexPath.row)")
        let vc = PanoramaViewController(urlPath: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492061708570&di=b1a94c9aa3cd17d41ae84d5757b41ef3&imgtype=0&src=http%3A%2F%2Fimg05.tooopen.com%2Fimages%2F20150613%2Ftooopen_sy_130264211556.jpg") 
        self.present(vc!, animated: true, completion: nil) 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
