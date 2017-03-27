//
//  LoginViewModel.swift
//  Cloudin
//
//  Created by 住朋购友 on 2017/3/27.
//  Copyright © 2017年 子轩. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources



class LoginViewModel {
    
    // input 监听数据      用于 UI 控件值 绑定 VM
    let username = Variable<String>("")     //用户名称的数据
    let password  = Variable<String>("")    //密码的数据
    // 注册按钮点击 绑定的 事件
    let LoginEvent = PublishSubject<Void>()
    
    // 保存返回数据
    var LoginResult: Observable<ValidationResult>? = nil
    
    init( ) {
        Login()
    }
    
    //请求登录
    func Login(){
        
        
        let parameter = Observable.combineLatest(username.asObservable(),password.asObservable()){($0,$1)}
        LoginResult = LoginEvent.asObserver()
            .withLatestFrom(parameter)
            .flatMapLatest({ (name,pwd) -> Observable<ValidationResult> in
                //业务处理逻辑处理
                
                //------------用户名处理
                if(name==""){
                    //空值处理
                    return Observable.just(ValidationResult.empty)
                }
                if(name.characters.count != 11){
                    //校验手机号码
                    return Observable.just(ValidationResult.error)
                    
                }
                
                
                //----------------密码处理
                if(pwd==""){
                    //空值处理
                    return Observable.just(ValidationResult.empty)
                    
                }
                if(pwd.characters.count < 6){
                    //密码位数不能小于6位
                    return Observable.just(ValidationResult.error)
                    
                }
                
                return Observable.just(ValidationResult.ok)
                
            }).shareReplay(1)
        
        
        
    }
    
    
    
}
