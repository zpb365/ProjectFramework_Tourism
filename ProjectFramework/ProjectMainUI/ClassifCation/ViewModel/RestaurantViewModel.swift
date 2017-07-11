//
//  RestaurantViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/25.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class RestaurantViewModel {
    var ListData = [RestaurantModel]()
    //餐厅列表
    func GetChannelsRestaurantList(SearchTitle:String,ScreenTitle:String,SalesPriorityEnum:Int,ComprehensiveSortingEnum:Int,PageIndex:Int,PageSize:Int,ClassID:Int,result:((_ result:Bool?,_ NoMore:Bool?,_ Nodata:Bool?) -> Void)?){
        let parameters=["PageIndex":PageIndex,"PageSize":PageSize,"ScreenTitle":ScreenTitle,"SearchTitle":SearchTitle,"SalesPriorityEnum":SalesPriorityEnum,"ComprehensiveSortingEnum":ComprehensiveSortingEnum,"ClassID":ClassID] as [String : Any]
        
        CommonFunction.Global_Get(entity: RestaurantModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetChannelsRestaurantList", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                //没有数据
                if(resultModel?.ret==5){
                    result?(true,false,true)
                    return
                }
                if(resultModel?.ret==6){
                    result?(true,true,false)
                    return
                }
                let model =  resultModel?.Content   as!  [RestaurantModel]
                if(PageIndex>=2){
                    for item in model {
                        self.ListData.append(item)
                    }
                }else{
                    self.ListData = model
                }
                result?(true,false,false)
            }else{
                result?(false,false,false)
            }
        }
    }

}
