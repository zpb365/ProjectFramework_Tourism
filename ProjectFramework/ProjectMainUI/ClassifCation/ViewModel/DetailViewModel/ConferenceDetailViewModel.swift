//
//  ConferenceDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ConferenceDetailViewModel {
    var ListData = ConferenceDetailModel()
    //主数据
    func GetChannelsMeetingDetails(MeetingID:Int ,PageIndex:Int ,PageSize:Int ,SelectDateTime:String ,TimeInterval:Int ,result:((_ result:Bool?) -> Void)?) {
        let parameters=["MeetingID":MeetingID,"PageIndex":PageIndex,"PageSize":PageSize,"SelectDateTime":SelectDateTime,"TimeInterval":TimeInterval] as [String : Any]
        CommonFunction.Global_Get(entity: ConferenceDetailModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetChannelsMeetingDetails", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                if(resultModel?.ret==5){
                       result?(true)
                    return
                }
                self.ListData = resultModel?.Content   as!  ConferenceDetailModel
                result?(true)
            }else{
                result?(false)
            }
        }
    }
    //获取会展产品数据
    func GetMeetingDetailsProduct(MeetingID:Int ,SelectDateTime:String ,TimeInterval:Int ,result:((_ result:Bool?) -> Void)?) {
        let parameters=["MeetingID":MeetingID,"SelectDateTime":SelectDateTime,"TimeInterval":TimeInterval] as [String : Any]
        
        CommonFunction.Global_Get(entity: MeetingProduct_List(), IsListData: true, url: HttpsUrl+"api/Channels/GetMeetingDetailsProduct", isHUD: true, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                //没有数据
                if(resultModel?.ret==5){
                    self.ListData.MeetingProduct?.removeAll()
                    result?(true)
                    return
                }
                self.ListData.MeetingProduct?=resultModel?.Content   as!  [MeetingProduct_List]
                result?(true)
            }else{
                result?(false)
            }
            
        }
    }
}
