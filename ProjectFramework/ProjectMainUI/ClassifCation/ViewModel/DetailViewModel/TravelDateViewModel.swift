//
//  TravelDateViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelDateViewModel: NSObject {
    var ListData = [ScenicDatePriceModel]()
    
    func GetTravelAgencySelectedTimeList(TravelAgencyID:Int,TravelAgencyProductID:Int,result:((_ result:Bool?) -> Void)?) {
        let parameters=["TravelAgencyID":TravelAgencyID,"TravelAgencyProductID":TravelAgencyProductID]
        //api/Channels/GetScenicSelectedTimeList
        CommonFunction.Global_Get(entity: ScenicDatePriceModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetTravelAgencySelectedTimeList", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            
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
