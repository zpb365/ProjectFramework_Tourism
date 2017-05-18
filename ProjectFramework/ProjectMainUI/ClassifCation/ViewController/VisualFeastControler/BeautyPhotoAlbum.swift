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
    var dataArray = [ClassBeautifulPictureList_Item]()
    var image_url = Array<String>()
    var title_Array = Array<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "美图相册"
        for i in 0..<dataArray.count {
            let url = "\(HttpsUrlImage)\(self.dataArray[i].PhotoUrl)"
            image_url.append(url)
            title_Array.append(self.dataArray[i].PhotoDescribe)
        }
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor().TransferStringToColor("#FF4081"), size: CGSize.init(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)),for: UIBarMetrics.default)
        
    }
    //MARK: initUI
    func initUI() -> Void {
        
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y:CommonFunction.NavigationControllerHeight, w: self.view.frame.width, h: self.view.frame.height - CommonFunction.NavigationControllerHeight)
        self.tableView.backgroundColor = UIColor().TransferStringToColor("E1E3ED")
        self.numberOfSections = 1
        self.numberOfRowsInSection = self.dataArray.count
        self.tableViewheightForRowAt = 200
        self.header.isHidden = true
        self.footer.isHidden = true
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! BeautyPhotoCell
        cell.InitConfig(self.dataArray[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ImagePreviewViewController( ImageUrlList: image_url ,IsDescribe: true,DescribeList: title_Array )
        self.navigationController?.pushViewController(vc, animated: true )
    }
    
}
