//
//  SpecialtyDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SpecialtyDetailViewModel: NSObject {
    var ListData = SpecialtyDetailModel()
    //主数据
    func GetChannelsSpecialitiesDetails(SpecialitiesID:Int ,PageIndex:Int ,PageSize:Int  ,result:((_ result:Bool?) -> Void)?) {
        let parameters=["SpecialitiesID":SpecialitiesID,"PageIndex":PageIndex,"PageSize":PageSize] as [String : Any]
        CommonFunction.Global_Get(entity: SpecialtyDetailModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetChannelsSpecialitiesDetails", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                if(resultModel?.ret == 5){
                    result?(true)
                    return
                }
                self.ListData = resultModel?.Content   as!  SpecialtyDetailModel
                result?(true)
            }else{
                result?(false)
            }
        }
    }
    
}
