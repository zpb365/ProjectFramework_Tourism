//
//  HomeViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation


class HomeViewModel    {
    
    var ListData = HomeModel()
    
    func GetHomeInfo (result:((_ result:Bool?) -> Void)?)   {
        CommonFunction.Global_Get(entity: HomeModel(), IsListData: false, url: HttpsUrl+"api/Home/GetHomeInfo", isHUD: false, isHUDMake: false, parameters:nil) { (resultModel) in
            if(resultModel?.Success==true){
                self.ListData = resultModel?.Content   as!  HomeModel
                result?(true)
            }else{
                result?(false)
            }
            
        }
    }
    
}
