//
//  GuideBooxDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class GuideBookDetailViewModel {
    
    var ListData = GuideDetailModel()
    
    func GetChannelsCiceroneDetails(CiceroneID:Int,result:((_ result:Bool?) -> Void)?){
        
        let parameters=["CiceroneID":CiceroneID]
        
        CommonFunction.Global_Get(entity: GuideDetailModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetChannelsCiceroneDetails", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                //没有数据
                if(resultModel?.ret==5){
                    result?(true)
                    return
                }
                 self.ListData = resultModel?.Content   as!  GuideDetailModel
             
                result?(true)
            }
            else{
                result?(false)
            }
        }
    }
}
