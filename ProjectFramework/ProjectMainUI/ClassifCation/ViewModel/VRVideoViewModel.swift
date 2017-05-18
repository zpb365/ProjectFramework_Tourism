//
//  VRVideoViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/24.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class VRVideoViewModel {
    var ListData = [ClassVRVideoClassList_Item]()
    
    func GetChannelsVideo(PageIndex:Int,PageSize:Int,result:((_ result:Bool?,_ NoMore:Bool?) -> Void)?){
        let parameters=["PageIndex":PageIndex,"PageSize":PageSize]
        
        CommonFunction.Global_Get(entity: ClassVRVideoClassList_Item(), IsListData: true, url: HttpsUrl+"api/Channels/GetChannelsVideo", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                if(resultModel?.ret==5){
                    result?(true,false)
                    return
                }
                if(resultModel?.ret==6){
                    result?(true,true)
                    return
                }
                let model =  resultModel?.Content   as!  [ClassVRVideoClassList_Item]
                if(PageIndex>=2){
                    for item in model {
                        self.ListData.append(item)
                    }
                }else{
                    self.ListData = model
                }
                result?(true,false)
            }else{
                result?(false,false)
            }
        }
        
    }

}
