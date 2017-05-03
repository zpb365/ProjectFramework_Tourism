//
//  GuideViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/26.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GuideViewModel{
    var ListData = [GuideModel]()
    
    func GetChannelsCiceroneList(PageIndex:Int,PageSize:Int,result:((_ result:Bool?,_ NoMore:Bool?,_ Nodata:Bool?) -> Void)?){
        
        let parameters=["PageIndex":PageIndex,"PageSize":PageSize]
        
        CommonFunction.Global_Get(entity: GuideModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetChannelsCiceroneList", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                //没有数据
                if(resultModel?.ret==5){
                    result?(true,false,true)
                    return
                }
                //没有更多数据
                if(resultModel?.ret==6){
                    result?(true,true,false)
                    return
                }
                //有数据PageIndex>=2
                let model =  resultModel?.Content   as!  [GuideModel]
                if(PageIndex>=2){
                    for item in model {
                        self.ListData.append(item)
                    }
                }else{
                    self.ListData = model
                }
                result?(true,false,false)
            }
            else{
                result?(false,false,false)
            }
        }
    }
    
    //景区列表搜索
    func GetChannelsCiceroneList(ChannelID:Int,Title:String,PageIndex:Int,PageSize:Int,result:((_ result:Bool?,_ NoMore:Bool?, _ Nodata:Bool?) -> Void)?) {
        let parameters = ["PageIndex":PageIndex,"PageSize":PageSize,"ChannelID":ChannelID,"Title":Title] as [String : Any]
        CommonFunction.Global_Get(entity: GuideModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetChannelsSearchList", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                //没有数据
                if(resultModel?.ret==5){
                    result?(true,true,false)
                    return
                }
                if(resultModel?.ret==6){
                    result?(true,true,false)
                    return
                }
                let model =  resultModel?.Content   as!  [GuideModel]
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
