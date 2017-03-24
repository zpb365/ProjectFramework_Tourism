//
//  ScenicSpotMain.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/3/13.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit 

class ScenicSpotMain: CustomTemplateViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    @IBOutlet weak var buttonBar: UIView!
    
    ///按钮折叠）属性
    lazy var rightImage:UIButton = {
        
        let rightImage = UIButton.init(frame: CommonFunction.CGRect_fram(CommonFunction.kScreenWidth - 5 - 20, y: 25, w: 16, h: 16))
        rightImage.isSelected=true
        //
        rightImage.setImage(UIImage.init(named: "arrowdown"), for: .normal)
        rightImage.setImage(UIImage.init(named: "arrowup"), for: .selected)
        rightImage.addTarget(self, action: #selector(footerTap), for: .touchUpInside)
        return rightImage
    }()
    ///组尾 购票
    lazy var sectionFooter:UIView = {
        let sectionFooter = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
        sectionFooter.backgroundColor = UIColor.white
        
        let button = UIButton.init(type: .custom)
        button.frame = CommonFunction.CGRect_fram(5, y: 10, w: 60, h: 40)
        button.setTitle("购票", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setImage(UIImage(named: "tikect"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.isUserInteractionEnabled = false
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.adjustsImageWhenHighlighted = false
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(footerTap))
        sectionFooter.addGestureRecognizer(tap)
        sectionFooter.addSubview(button)
        
        return  sectionFooter
    }()
    lazy var scenicIntroduce:UIView = {
        let scenicIntroduce = UIView().headView(width: CommonFunction.kScreenWidth, height: 40, leftViewColor: UIColor().TransferStringToColor("#00C7D8"), title: "景区介绍")
        return scenicIntroduce
    }()
    lazy var sectionConment:UIView = {
        let sectionConment = Bundle.main.loadNibNamed("CommentSectionView", owner: self, options: nil)?.last
        
        return sectionConment as! UIView
    }()
    
    let identiFier  = "TicketCell"
    let identifier2 = "ScenicIntroduceCell"
    let identifier3 = "UserCommentCell"
    
    var CustomNavBar:UINavigationBar!=nil
    var backBtn:UIButton!=nil
    
    var cellectionBtn:UIButton!=nil
    var shareBtn:UIButton!=nil
    var alph: CGFloat = 0
    var HTMLString: String! = nil
    var height: CGFloat = 50
    var flag: Bool = false
    var modelArray = Array<Any>()
    var isChange: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        self.setNavBar()
        self.setHeadView()
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    //MARK: 获取数据/Users/zhupenggouyou/Documents/ProjectFramework_Tourism/html.txt
    
    func getData() -> Void {
        do {
            //发现此方法在iOS9会闪退
            let str=try NSString(contentsOfFile: "/Users/zhupenggouyou/Documents/ProjectFramework_Tourism/html.txt",encoding: String.Encoding.utf8.rawValue)
            HTMLString = str as String!
            print("我执行这里了1")
        }
        catch {
            HTMLString = ""
            print("我执行这里了2")
        }
        
    }
    
    
    //MARK: 设置头部
    func setHeadView() -> Void {
        let titleArray: Array=["购票","景点介绍","用户点评"]
        for i in 0..<titleArray.count {
            let title = titleArray[i]
            let button = UIButton.init(type: .system)
            let frame_x = CGFloat((CommonFunction.kScreenWidth/CGFloat(titleArray.count))*CGFloat(i))
            button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:CommonFunction.kScreenWidth / CGFloat(titleArray.count) , h: 35)
            button.tag = 1 + i
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.black, for: .normal)
            button.addTarget(self, action:#selector(headerClick), for: .touchUpInside)
            button.adjustsImageWhenHighlighted = false
            if (i == 0) {
                let bottomLine = UIView()
                bottomLine.tag = 666
                bottomLine.frame = CommonFunction.CGRect_fram(0, y: 35, w: 70, h: 3)
                bottomLine.center.x = button.center.x
                bottomLine.backgroundColor = UIColor().TransferStringToColor("#03A9F4")
                buttonBar.addSubview(bottomLine)
            }
            buttonBar.addSubview(button)
        }
    }
    
  
    //MARK: 设置导航栏
    func setNavBar() -> Void {
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除 
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor().withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
        CustomNavBar.clipsToBounds=true
        self.view.addSubview(CustomNavBar)
        
        let CustomNavItem = UINavigationItem()
        //返回按钮
        backBtn = UIButton(type: .custom)
        backBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        backBtn.tag = 100
        backBtn.backgroundColor = UIColor.gray
        backBtn.layer.cornerRadius = 15
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        //收藏
        cellectionBtn = UIButton(type: .custom)
        cellectionBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        cellectionBtn.adjustsImageWhenHighlighted = false
        cellectionBtn.tag = 101
        cellectionBtn.backgroundColor = UIColor.gray
        cellectionBtn.layer.cornerRadius = 15
        cellectionBtn.setImage(UIImage(named: "scanning"), for: .normal)
        cellectionBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        //分享
        shareBtn = UIButton(type: .custom)
        shareBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        shareBtn.tag = 102
        shareBtn.adjustsImageWhenHighlighted = false
        shareBtn.backgroundColor = UIColor.gray
        shareBtn.layer.cornerRadius = 15
        shareBtn.setImage(UIImage(named: "scanning"), for: .normal)
        shareBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)
        
        CustomNavItem.leftBarButtonItem=UIBarButtonItem.init(customView: backBtn)
        CustomNavItem.rightBarButtonItems=[UIBarButtonItem.init(customView: shareBtn),UIBarButtonItem.init(customView: cellectionBtn)]

        
        CustomNavBar.pushItem(CustomNavItem, animated: true)
    }
    //导航栏按钮方法
    func buttonClick(_ button: UIButton){
        switch button.tag {
        case 100:
            _ = self.navigationController?.popViewController(animated: true)
            break
        case 101:
            print("收藏")
            break
        case 102:
            print("分享")
            break
        default:
            break
        }
       
    }
    
    //MARK: initUI
    
    func initUI(){
        
        let model = UserCommentModel()
        model.comment = "呵呵呵呵呵呵呵呵呵呵额呵呵撒会受到hi欧委会IQ哦好滴哦我去hi噢hi噢hi噢hi哦我回去低耦合我我哦青海地区哦和我我odhqioifuheui手动切换为我哦亲hi殴打hi哦我去hi哦"
        model.imageArray = ["icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg","icon0.jpg"]
        model.nickName = "住朋购友"
        modelArray.append(model)
        //组尾添加按钮
        sectionFooter.addSubview(rightImage)
        
        self.InitCongif(tableView)
        self.tableView.frame = CommonFunction.CGRect_fram(0, y:0, w: self.view.frame.width, h: self.view.frame.height)
        self.tableView.tableHeaderView = tableViewHead
        self.tableView.register(UserCommentCell.self, forCellReuseIdentifier: identifier3)
        self.header.isHidden = true
        
        
    }
    //MARK: tableViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = scrollView.contentOffset.y
        //导航栏渐变
        if (offset <= 64) {
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor().withAlphaComponent(0), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray
            cellectionBtn.backgroundColor = UIColor.gray
            shareBtn.backgroundColor = UIColor.gray
        }
        else{
            alph = 1-((200 - offset)/200)
            CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: CommonFunction.SystemColor().withAlphaComponent(alph), size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
            backBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
            cellectionBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
            shareBtn.backgroundColor = UIColor.gray.withAlphaComponent(1-alph)
        }
        //筛选条悬浮效果
        if (offset > tableViewHead.frame.height - 64 - 40) {
            _ = self.view.subviews.map({
                if(($0.viewWithTag(99)) != nil){
                    return
                }
            }) 
            self.view.addSubview(buttonBar)
            buttonBar.frame=CGRect(x: 0, y: 64, width: CommonFunction.kScreenWidth, height: 40)
            self.view.bringSubview(toFront: buttonBar)
        }else{
            buttonBar.frame=CGRect(x: 0, y: 330, width: CommonFunction.kScreenWidth, height: 40)
            tableViewHead.addSubview(buttonBar)
            
        }
        //是否是滑动判断
        if isChange {
            //筛选条底部线移动
            if (offset < CGFloat (100 * (rightImage.isSelected ? 10 : 0)) + tableViewHead.frame.height){
                //底部线滑动
               self.btoomLineMove(tag: 1)
            }
            else if (offset > CGFloat (100 * (rightImage.isSelected ? 10 : 0)) + tableViewHead.frame.height && offset < CGFloat (100 * (rightImage.isSelected ? 10 : 0)) + tableViewHead.frame.height + height){
                self.btoomLineMove(tag: 2)
            }
            else if (offset > CGFloat (100 * (rightImage.isSelected ? 10 : 0)) + tableViewHead.frame.height + height){
               self.btoomLineMove(tag: 3)
            }
        }
    }
    //滑线效果
    func btoomLineMove(tag:Int) -> Void {
        UIView.animate(withDuration: 0.3) {
            let button = self.buttonBar.viewWithTag(tag) as! UIButton
            let line = self.buttonBar.viewWithTag(666)
            line?.center.x = button.center.x
        }
    }
    //MARK: 开始拖动时调用的方法
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isChange = true

    }
        //组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    var _numberOfRowsInSection = [0,0,1,5]
    
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _numberOfRowsInSection[1] = rightImage.isSelected ? 10 : 0
        return _numberOfRowsInSection[section]
    }
    var _heightForRowAt = [CGFloat(0),CGFloat(100),CGFloat(0),CGFloat(0)]
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        _heightForRowAt[2] =  height > CGFloat (50) ? height : CGFloat(50)
        let model = self.modelArray[0] as! UserCommentModel
        _heightForRowAt[3] = self.tableView.getHeightWithCell(lableWidth: CommonFunction.kScreenWidth - 35, commont: model.comment, imageArray: model.imageArray, showCount: model.imageArray.count, rowCount: 4, contenViewWidth: CommonFunction.kScreenWidth - 35, xMargin: 10, yMargin: 10) + 48 + 10
//        print("高度====",_heightForRowAt[3])
        return _heightForRowAt[indexPath.section]
    }
    var _heightForHeaderInSection = [0,0,40,50]
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return CGFloat(_heightForHeaderInSection[section])
    }
    var _viewForHeaderInSection = [UIView(),UIView(),UIView(),UIView()]
    //组头
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        _viewForHeaderInSection[2] = scenicIntroduce
        _viewForHeaderInSection[3] = sectionConment
        return _viewForHeaderInSection[section]
    }
    var _viewForFooterInSection = [UIView(),UIView(),UIView(),UIView()]
    //组尾
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        _viewForFooterInSection[0]=sectionFooter
        return _viewForFooterInSection[section]
    }
    let _heightForFooterInSection = [50,0,0,0]
    //组尾高
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return CGFloat(_heightForFooterInSection[section])
    }
    //数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! TicketCell
            return cell
        }
        if (indexPath.section == 2) {
            var cell  = tableView.dequeueReusableCell(withIdentifier: identifier2) as! ScenicIntroduceCell
            if (flag == false) {
                cell = ScenicIntroduceCell.init(style: .subtitle, reuseIdentifier: identifier2)
                cell.selectionStyle = .none
                cell.InitConfig(HTMLString)
            }
            //标记  不给WKwebViw一直加载
            flag = true
            cell.FuncCallbackValue(value: { [weak self]( height) -> Void in
                self?.height = height
                self?.tableView.reloadData()
            })
            return cell
        }
        if (indexPath.section == 3) {
//            let cell  = tableView.dequeueReusableCell(withIdentifier: identifier3) as! UserCommentCell
            let cell = UserCommentCell.init(style: .subtitle, reuseIdentifier: identifier3)
            cell.InitConfig(self.modelArray[0])
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    //MARK: 组头按钮方法
    func headerClick(_ button: UIButton) {
        isChange = false
        //底部线滑动
        UIView.animate(withDuration: 0.3) {
            let line = self.buttonBar.viewWithTag(666)
            line?.center.x = button.center.x
        }
        //0头  1 购票   2 景区介绍  3 评论

        if (button.tag == 1 && rightImage.isSelected == false){
            self.tableView.setContentOffset(CGPoint.init(x: 0, y: tableViewHead.frame.height - 64 - 40), animated: true)
            return
        }
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: button.tag), at: .middle, animated: true)
        
    }
    //MARK: 折叠效果
    func footerTap() -> Void {
        //反选刷新数据
        rightImage.isSelected = !rightImage.isSelected
       self.tableView.reloadSections(NSIndexSet.init(index: 1) as IndexSet, with: .automatic)
    }
    
    deinit {
        print("shifnagl")
    }
}
