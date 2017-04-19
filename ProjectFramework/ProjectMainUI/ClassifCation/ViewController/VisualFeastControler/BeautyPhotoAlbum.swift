//
//  BeautyPhotoAlbum.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/14.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class BeautyPhotoAlbum: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let identiFier = "BeautyPhotoCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "美图相册"
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#FF4081"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    //MARK: initUI
    func initUI() -> Void {
        
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y:CommonFunction.NavigationControllerHeight, w: self.view.frame.width, h: self.view.frame.height - CommonFunction.NavigationControllerHeight)
        self.tableView.backgroundColor = UIColor().TransferStringToColor("E1E3ED")
        self.numberOfSections = 1
        self.numberOfRowsInSection = 10
        self.tableViewheightForRowAt = 200
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! BeautyPhotoCell
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urllist=["http://pic9.nipic.com/20100902/2029588_234330095230_2.jpg"
            ,"http://pic1a.nipic.com/2008-08-26/200882614319401_2.jpg"
            ,"http://www.ahhnh.com/data/upload/2015-10/2015101940975833.jpg"
            ,"http://pic10.nipic.com/20100929/4879567_114926982000_2.jpg"
            ,"http://img2.imgtn.bdimg.com/it/u=2081796248,4191591232&fm=21&gp=0.jpg"]
        let describeList=["张三","李四","李四","李四","李四"]
        let vc = ImagePreviewViewController( ImageUrlList: urllist ,IsDescribe: true,DescribeList: describeList )
        self.navigationController?.pushViewController(vc, animated: true )
    }
    
}
