//
//  LoginViewController.swift
//  Cloudin
//
//  Created by hcy on 2017/3/8.
//  Copyright © 2017年 子轩. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewControllerTwo: UIViewController
{
    
    fileprivate let disposeBag   = DisposeBag() //创建一个处理包（通道）
    let _LoginViewModel = LoginViewModel()   //数据处理 (VM)
    
    //类似于OC中的typedef
    typealias CallbackValue=(_ value:Bool)->Void
    
    //声明一个闭包
    var myCallbackValue:CallbackValue?
    //下面这个方法需要传入上个界面的函数指针
    func  Callback_Value(_ value:CallbackValue?){
        //将函数指针赋值给闭
        myCallbackValue = value
    }
    
    ///返回 按钮
    lazy var backbtn:UIButton =
        {
            let btn = UIButton(frame: CGRect(x: 5, y: 22, width: 50, height: 43))
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitle(  "X",   for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            btn.rx.tap.subscribe(      //返回
                onNext: { [weak self] value in
                    self?.dismiss(animated: true, completion: nil)
            }).addDisposableTo(self.disposeBag)
            return btn
    }()
    
    var _LoginView:LoginView?=nil
    
    
    override func viewDidLoad()
    { 
        super.viewDidLoad()
        _LoginView = LoginView(frame: self.view.frame)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true);
        self.view.addSubview(_LoginView!)
        self.view.addSubview(backbtn)
        
        _LoginView?.UserNameText.rx.text.orEmpty
            .bindTo(_LoginViewModel.username) //手机号绑定
            .addDisposableTo(disposeBag)
        
        _LoginView?.pawNameText.rx.text.orEmpty
            .bindTo(_LoginViewModel.password) //手机号绑定
            .addDisposableTo(disposeBag)
         
        _LoginView?.registerbtn.rx.tap.subscribe(      //注册事件
            onNext:{ [weak self] value in
                let vc = registerViewController()
                self?.present(vc, animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
        
        
        _LoginView?.loginbtn.rx.tap.subscribe(      //登录事件
            onNext:{ [weak self] value in
                 print("登录")
        }).addDisposableTo(disposeBag)
        
        
        _LoginView?.Forgetpassword.rx.tap.subscribe(      //忘记密码事件
            onNext:{ [weak self] value in
                let vc = ForgotPasswordController()
                self?.present(vc, animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
        
    }
 
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
   
    
    deinit {
        debugPrint("页面销毁")
    }
    
}
