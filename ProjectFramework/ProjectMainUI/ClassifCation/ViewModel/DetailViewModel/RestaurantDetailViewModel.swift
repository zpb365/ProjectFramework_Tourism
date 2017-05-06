//
//  RestaurantDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/5.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class RestaurantDetailViewModel {
    var ListData = RestaurantDetailModel()
    
    func GetChannelsRestaurantDetails(RestaurantID:Int ,PageIndex:Int ,PageSize:Int  ,result:((_ result:Bool?) -> Void)?) {
        let parameters=["RestaurantID":RestaurantID,"PageIndex":PageIndex,"PageSize":PageSize]
        
        CommonFunction.Global_Get(entity: RestaurantDetailModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetChannelsRestaurantDetails", isHUD: true, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                
                self.ListData = resultModel?.Content   as!  RestaurantDetailModel
                result?(true)
            }else{
                result?(false)
            }
            
        }
    }
}
