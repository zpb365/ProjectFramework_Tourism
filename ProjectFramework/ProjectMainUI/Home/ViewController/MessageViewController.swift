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
    
    fileprivate let viewModel = MessageViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="您的消息"
        tableView.frame=CGRect(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: self.view.frame.height - CommonFunction.NavigationControllerHeight)
        self.tableViewheightForRowAt=55
        self.numberOfSections=1
        self.InitCongif(tableView)
        self.header.isHidden=true
        getData()
     
          
    }
    
    func getData(){
        viewModel.GetPushMessageInfo { (result) in
            if(result==true){
                self.numberOfRowsInSection=self.viewModel.ListData.count
               
                self.RefreshRequest(isLoading: false,isHiddenFooter: true)
            }else{
                self.RefreshRequest(isLoading: false,isHiddenFooter: true,isLoadError: true)
                
            }
        }
    }
    
    
    override func Error_Click() {
        self.viewModel.ListData.removeAll()
        self.numberOfRowsInSection=self.viewModel.ListData.count
        self.RefreshRequest(isLoading: true,isHiddenFooter: true)
        getData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as! MessageViewCell
        cell.InitConfig(viewModel.ListData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = PayForSuccess()
//        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
