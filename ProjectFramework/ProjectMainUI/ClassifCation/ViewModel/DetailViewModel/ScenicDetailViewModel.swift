//
//  ScenicDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/27.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class ScenicDetailViewModel {
    var ListData = ScenicDetailModel()
    
    func GetChannelsScenicDetails(ScenicID:Int,result:((_ result:Bool?) -> Void)?) {
        let parameters=["ScenicID":ScenicID]
        
        CommonFunction.Global_Get(entity: ScenicDetailModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetChannelsScenicDetails", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                if resultModel?.ret == 5{
                    result?(true)
                    return
                }
                self.ListData = resultModel?.Content   as!  ScenicDetailModel
                result?(true)
            }else{
                result?(false)
            }

        }
    }
}
