//
//  regiestViewModel.swift
//  Cloudin
//
//  Created by 住朋购友 on 2017/3/24.
//  Copyright © 2017年 子轩. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources



class regiestViewModel {
    
    // input 监听数据      用于 UI 控件值 绑定 VM
    let username = Variable<String>("")     //用户名称的数据
    let password  = Variable<String>("")    //密码的数据
    let VerificationCode = Variable<String>("") //验证码数据
    // 注册按钮点击 绑定的 事件
    let registerEvent = PublishSubject<Void>()
    // 验证码按钮点击 绑定的 事件
    let VerificationCodeEvent = PublishSubject<Void>()
    
    // 注册返回数据
   var registeResult: Observable<ValidationResult>? = nil
   
    init( ) {
        register()
        GetVerificationCode()
    }
    
    //注册
    func register(){
       
        
       let parameter = Observable.combineLatest(username.asObservable(),password.asObservable(),VerificationCode.asObservable()){($0,$1,$2)}
        registeResult = registerEvent.asObserver()
            .withLatestFrom(parameter)
            .flatMapLatest({ (name,pwd,vercode) -> Observable<ValidationResult> in
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
                
                
                //----------验证码处理
                 if(vercode==""){
                    //空值处理
                    return Observable.just(ValidationResult.empty)
                    
                 }
                
            return Observable.just(ValidationResult.ok)
            
        }).shareReplay(1)
        
        
        
    }
    
    //获取验证码
    func GetVerificationCode(){
        
       
       _ = VerificationCodeEvent.asObserver().flatMapLatest { () ->  Observable<ValidationResult> in
            
            //------------用户名处理
            if(self.username.value==""){
                //空值处理
                print("空处理")
                return  Observable.just(ValidationResult.empty)
            }
            if(self.username.value.characters.count != 11){
                //校验手机号码
                return  Observable.just(ValidationResult.error)
            }
            
            return Observable.just(ValidationResult.ok)
            
        }.shareReplay(1)
       
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
