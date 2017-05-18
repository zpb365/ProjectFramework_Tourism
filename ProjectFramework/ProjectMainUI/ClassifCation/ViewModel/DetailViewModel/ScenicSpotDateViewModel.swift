//
//  ScenicSpotDateViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/28.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class ScenicSpotDateViewModel {
    var ListData = [ScenicDatePriceModel]()
    
    func GetScenicSelectedTimeList(ScenicID:Int,ScenicProductID:Int,result:((_ result:Bool?) -> Void)?) {
        let parameters=["ScenicID":ScenicID,"ScenicProductID":ScenicProductID]
                                                                                                    //api/Channels/GetScenicSelectedTimeList
        CommonFunction.Global_Get(entity: ScenicDatePriceModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetScenicSelectedTimeList", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            
            if(resultModel?.Success==true){
                if resultModel?.ret == 5{
                    result?(true)
                    return
                }
                self.ListData = resultModel?.Content   as!  [ScenicDatePriceModel]
                result?(true)
            }
            else{
                result?(false)
            }
            
        }
    }
}
