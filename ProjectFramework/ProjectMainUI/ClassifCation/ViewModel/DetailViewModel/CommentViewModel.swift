//
//  CommentViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/5.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class CommentViewModel: NSObject {
    var ListData = [CommentMeModel]()
    
    func GetAllCommentMsg(ChannelsID:Int,ChannelsListID:Int,PageIndex:Int,PageSize:Int,result:((_ result:Bool?,_ NoMore:Bool?) -> Void)?){
        let parameters=["ChannelsID":ChannelsID,"ChannelsListID":ChannelsListID,"PageIndex":PageIndex,"PageSize":PageSize]
        
        CommonFunction.Global_Get(entity: CommentMeModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetAllCommentMsg", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                
                if(resultModel?.ret==6){
                    result!(true,true)
                    return
                }
                if resultModel?.Content != nil{
                    let model =  resultModel?.Content   as!  [CommentMeModel]
                    if(PageIndex>=2){
                        for item in model {
                            self.ListData.append(item)
                        }
                    }else{
                        self.ListData = model
                    }
                    result?(true,false)
                }else{
                    return 
                }
                
            }else{
                result?(false,false)

            }
        }
    }
}
