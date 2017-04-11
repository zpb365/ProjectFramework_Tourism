//
//  OrderSearch.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class OrderSearch: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var baseImageView: UIImageView!
    @IBOutlet weak var textBaesView: UIView!
    @IBOutlet weak var oderTextField: UITextField!
    
    var CustomNavBar:UINavigationBar!=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLayoutSubviews() {
        baseImageView.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight)
        textBaesView.center.y = baseImageView.center.y - 40
        oderTextField.delegate = self
        oderTextField.returnKeyType = .search
    }
    //MARK: 取消键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    //MARK: 设置导航栏
    func setNavBar() -> Void{
        CustomNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight))
        //把导航栏渐变效果移除
        CustomNavBar.setBackgroundImage(UIImage().ImageWithColor(color: UIColor.clear, size: CGSize(width: CommonFunction.kScreenWidth, height: CommonFunction.NavigationControllerHeight)), for: .default)
        CustomNavBar.clipsToBounds=true
        self.view.addSubview(CustomNavBar)
        
        let CustomNavItem = UINavigationItem()
        //返回按钮
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CommonFunction.CGRect_fram(0, y: 0, w: 30, h: 30)
        backBtn.tag = 100
        backBtn.backgroundColor = UIColor.gray
        backBtn.layer.cornerRadius = 15
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.addTarget(self, action:#selector(buttonClick) , for: .touchUpInside)        
        CustomNavItem.leftBarButtonItem=UIBarButtonItem.init(customView: backBtn)
        CustomNavBar.pushItem(CustomNavItem, animated: true)
    }
    //导航栏按钮方法
    func buttonClick(_ button: UIButton){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
