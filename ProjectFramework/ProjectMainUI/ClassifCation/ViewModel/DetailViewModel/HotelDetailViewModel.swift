//
//  HotelDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/3.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HotelDetailViewModel {
    var ListData = HotelDetailModel()
    
    func GetChannelsHotelDetails(HotelID:Int ,PageIndex:Int ,PageSize:Int ,DateTimeBegin:String ,DateTimeEnd:String ,result:((_ result:Bool?) -> Void)?) {
        let parameters=["HotelID":HotelID,"PageIndex":PageIndex,"PageSize":PageSize,"DateTimeBegin":DateTimeBegin,"DateTimeEnd":DateTimeEnd] as [String : Any]
        
        
        CommonFunction.Global_Get(entity: HotelDetailModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetChannelsHotelDetails", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                
                self.ListData = resultModel?.Content   as!  HotelDetailModel
                result?(true)
            }else{
                result?(false)
            }
            
        }

    }
}
