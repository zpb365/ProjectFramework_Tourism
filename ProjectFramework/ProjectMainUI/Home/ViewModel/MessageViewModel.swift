//
//  MessageViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/19.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class MessageViewModel    {
    
    var ListData = [PushMessageInfoModel]() 
    
    func GetPushMessageInfo (result:((_ result:Bool?) -> Void)?)   {
        //如果登录了 则有userid  否则就是0
        CommonFunction.Global_Get(entity: PushMessageInfoModel(), IsListData: true, url: HttpsUrl+"api/Home/GetPushMessageInfo", isHUD: false, isHUDMake: false, parameters: ["UserID":Global_UserInfo.userid]) { (resultModel) in
            if(resultModel?.Success==true){
                 self.ListData = resultModel?.Content   as!  [PushMessageInfoModel]
                result?(true)
            }else{
               result?(false) 
            }
            
        }
    }
    
    
   
 
 

}
